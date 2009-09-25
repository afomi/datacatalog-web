class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :show_title, :mailer_set_url_options

  unless ["development", "test"].include?(Rails.env)
    rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ActionController::RoutingError, 
                ActionController::UnknownController,ActionController::UnknownAction, :with => :render_404
    rescue_from NoMethodError, ActiveRecord::StatementInvalid, ActionView::TemplateError, :with => :render_500
  end

  def render_404(e)
    render :template => 'home/notfound', :status => "404 Not Found"
  end
  
  def render_500(e)
    render :template => 'home/internal_error', :status => "500 Error"
  end

  private
  
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
        flash[:notice] = "You must be logged in to access this page"
        redirect_to signin_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to profile_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def mailer_set_url_options
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
end