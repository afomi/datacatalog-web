class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :show_title, :mailer_set_url_options, :set_analytics, :set_avatar

  unless ["development", "test"].include?(Rails.env)
    rescue_from ActiveRecord::RecordNotFound,
      ActiveRecord::RecordInvalid,
      ActionController::RoutingError,
      ActionController::UnknownController,
      ActionController::UnknownAction,
      :with => :render_404
    rescue_from NoMethodError,
      ActiveRecord::StatementInvalid,
      ActionView::TemplateError,
      :with => :render_500
  end

  def render_404(e)
    render :template => 'main/not_found', :status => "404 Not Found"
  end
  
  def render_500(e)
    render :template => 'main/internal_error', :status => "500 Error"
  end
  
  protected
    
  def extract_id(href)
    %r{/(.*)/(.*)}.match(href)[2]
  end

  private
  
  def set_avatar
    gender = rand(2) == 1 ? "male" : "female"
    ActionView::Base.default_gravatar_image =
      "http://nationaldatacatalog.com/images/avatar_#{gender}_lg.png"
  end
  
  def set_analytics
    analytics = YAML.load_file(Rails.root.to_s + "/config/analytics.yml")
    @analytics_key = analytics["key"]
  end
  
  def show_title
    @show_title = true
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to take that action."
      redirect_to signin_url
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to take that action."
      redirect_to profile_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  
  def handle_api_errors
    begin
      yield
    rescue DataCatalog::Unauthorized
      flash[:error] = "Unauthorized API Key! (#{DataCatalog.api_key})"
      redirect_to :back
    rescue DataCatalog::BadRequest => e
      flash[:error] = build_error_message(e.errors)
      redirect_to :back
    end
  end
  
  def build_error_message(error_hash)
    error_hash.map do |key, messages|
      "<p>#{key}</p>" +
      "<ul>" + messages.map { |m| "<li>#{m}</li>" }.join("") + "</ul>"
    end.join("")
  end
  
  def paginate(documents, radius=3)
    @page = params[:page].nil? ? 1 : params[:page].to_i
    max = documents.page_count
    if max > 0 && @page > max
      # "Could not find page number #{@page}. The maximum is #{max}."
      render_404(nil)
      return
    end
    list = 1.upto(max).map do |i|
      i if [1, max].include?(i) || (@page - radius .. @page + radius) === i
    end
    list.extend(Squeezable).squeeze
  end

end
