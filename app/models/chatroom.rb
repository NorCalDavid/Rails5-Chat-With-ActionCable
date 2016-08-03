class Chatroom < ApplicationRecord
	has_many :chatroom_users
	has_many :user, through: :chatroom_users
	has_many :messages
end
