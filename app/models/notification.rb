class Notification < ApplicationRecord
  extend Enumerize
  
  enumerize :color, in: { :blue => 1, :teal => 2, :cyan => 3, 
  												:green => 4, :amber => 5, :orange => 6,
  												:pink => 7, :red => 8, :purple => 9,
  												:brown => 10, :grey => 11, :black => 12  }, predicates: { prefix: true }
  
  enumerize :icon, in: { :warning => 1, :alarm => 2, :help_outline => 3, :info_outline => 4, 
  											 :info => 5, :stars => 6, :flag => 7,
  											 :check_circle => 8, :done => 9, :done_all => 10,
  											 :mail => 11, :live_help => 12, :assignment_late => 13,
  											 :notifications_active => 14, :notifications => 15, 
  											 :notifications_none => 16, :notifications_off => 17  }, predicates: { prefix: true }
  
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, ->{ where(read_at: nil) }
  scope :recent, ->{ order(created_at: :desc).limit(5) }

  def color_name
  	return Notification.color_options[self.color][:name]
  end

  def color_class
  	return Notification.color_options[self.color][:class]
  end

  def color_code
  	return Notification.color_options[self.color][:code]
  end

  def self.color_options
  	return {  "blue" =>  	{ name: "Blue", 	class: "notification-blue", 		code: "#2196f3" },
				  		"teal" => 	{ name: "Teal", 	class: "notification-teal", 		code: "#009688" },
				  		"cyan" =>  	{ name: "Cyan", 	class: "notification-cyan", 		code: "#00bcd4" },
				  		"green" =>  { name: "Green", 	class: "notification-green", 	code: "#4caf50" },
				  		"amber" =>  { name: "Amber", 	class: "notification-amber", 	code: "#ffc107" },
				  		"orange" => { name: "Orange",	class: "notification-orange", 	code: "#ff9800" },
				  	  "pink" =>  	{ name: "Pink", 	class: "notification-pink", 		code: "#e91e63" },
				  	  "red" =>  	{ name: "Red", 		class: "notification-red", 		code: "#f44336" },
				  	  "purple" => { name: "Purple", class: "notification-purple", 	code: "#9c27b0" },
				  	  "brown" => 	{ name: "Brown", 	class: "notification-brown", 	code: "#795548" },
				  	  "grey" => 	{ name: "Grey", 	class: "notification-grey", 		code: "#9e9e9e" },
				  	  "black" => 	{ name: "Black", 	class: "notification-black", 	code: "#000000" }  }
  end 

end
