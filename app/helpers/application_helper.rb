# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def custom_error_messages
    { :header_message => "", :message => "The following problems occurred:" }
  end
  
  def active_if(options)
    return "" if options[:current_user] and !current_user
    if options[:action]
      options[:action].each do |action|
        return "active" if params[:action] == action
      end
    elsif options[:controller]
      options[:controller].each do |controller|
        return "active" if params[:controller] == controller
      end
    else
    end
    return ""
  end
  
  def show_flash_message
    message = ""
    flash.each do |name, msg|
      message += content_tag :div, msg, :id => "flash_#{name}"
    end
    message
  end
  
  def detail_field(obj, options)
    if options[:collection]
      return nil if obj.send(options[:attribute]).empty?
    else
      return nil if obj.send(options[:attribute]).blank?
    end
    
    dd_content = if options[:url]
      link_to(options[:value], options[:url])
    elsif options[:titleize]
      options[:value].titleize
    elsif options[:collection]
      options[:value].join(", ")
    else
      options[:value]
    end
    
    output = content_tag(:dt, (options[:label] || options[:attribute].to_s.humanize)) +
      content_tag(:dd, dd_content) +
      (options[:noclear] && !@clear ? "" : content_tag(:div, "", :class => 'clear'))
    @clear = !@clear
    output
  end 
  
  def kronos_to_string(kronos_hash)
    return '' if kronos_hash.blank?
    k = Kronos.from_hash(kronos_hash)
    k.valid? ? k.to_s : ''
  end
  
  def kronos_to_string_range(kronos_1, kronos_2)
    k1, k2 = kronos_to_string(kronos_1), kronos_to_string(kronos_2)
    k1.blank? || k2.blank? ? '' : "#{k1} to #{k2}"
  end
  
  def gravatar_for(user, options)
    options.reverse_merge!(:class => "avatar", :size => 64)
    gravatar_image_tag(user.email, :alt => user.display_name, 
                                   :title => user.display_name, 
                                   :class => options[:class],
                                   :width => options[:size],
                                   :height => options[:size],
                                   :gravatar => { :size => options[:size] })
  end
  
  def markdownize(text)
    RDiscount.new(text).to_html
  end
  
  def markdown_instructions
    "Use <a href=\"http://www.squarespace.com/display/ShowHelp?section=Markdown\" target=\"_blank\">Markdown</a> for formatting."
  end

  def star_class(rating)
    case rating
    when 1
      return "ratedOneStar"
    when 2
      return "ratedTwoStars"      
    when 3
      return "ratedThreeStars"      
    when 4
      return "ratedFourStars"  
    when 5
      return "ratedFiveStars"
    else
      return ""
    end
  end
  
  def rating_count(average, total)
    return "0" unless average
    return (total.to_i/average.to_i).to_i.to_s
  end
  
  def extract_id(href)
    /\/(.*)\/(.*)/.match(href)[2]
  end  

end
