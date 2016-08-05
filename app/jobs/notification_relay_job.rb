class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
  	if notification.notifiable.nil?
  		ap "In Here"
  		html = ApplicationController.render partial: "notifications/notification", locals: {notification: notification}, formats: [:html]
	    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  	else
  		ap "Else Here"
	    html = ApplicationController.render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
	    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
	  end
  end
end