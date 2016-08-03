module ApplicationHelper

	def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def resource_name
    :users
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

	def options_yes_no
    return [["Yes", true], ["No", false]]
  end

  def options_resource_style
    return [["Style 1", 1], ["Style 2", 2], ["Style 3", 3], ["Style 4", 4], ["Style 5", 5], ["Style 6", 6], ["Style 7", 7], ["Style 8", 8]]
  end

  def options_priority
    return [["Low", 1], ["Medium", 2], ["High", 3], ["Critical", 4]]
  end

  def options_status
    return [["New", 1], ["Pending", 2], ["Resolved", 3], ["Locked", 4], ["Closed", 5]]
  end

  def devise_background_video
    return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/video/DavidUli-Web-Homepage.mp4"
  end

  def devise_mapping_background_poster
    return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/video/DavidUli-Web-Homepage.1.png"
  end

  def homepage_background_video
    return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/video/DavidUli-Web-Homepage.mp4"
  end

  def homepage_background_poster
    return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/video/DavidUli-Web-Homepage.1.png"
  end

end
