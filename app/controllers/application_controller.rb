class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_notifications

  def set_notifications
    if user_signed_in?
      @notifications = current_user.notifications.order(id: :desc).limit(25) 
    else
      @notifications = nil
    end
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || profile_path
  end

  protected

	def authenticate_admin
    unless current_user.try(:admin?)
      redirect_to "/", :alert => "Access denied."
    end  
  end
  
end
