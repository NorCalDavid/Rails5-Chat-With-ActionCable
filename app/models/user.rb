class User < ApplicationRecord
  extend Enumerize

  enum role: [:user, :vip, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users 
  has_many :messages 

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_attached_file :image, styles: { mini:    ["50x50>", :jpg],
                                      thumb:   ["100x100#", :jpg],
                                      small:   ["200x200#", :jpg],
                                      medium:  ["300x300#", :jpg] },

                          convert_options: { mini: "-quality 50 -strip",
                                             thumb: "-quality 50 -strip",
                                             small: "-quality 50 -strip",
                                             medium: "-quality 60 -strip" },

                          storage: :s3,
                          s3_headers: { "Cache-Control" => "max-age=31557600" },
                          s3_protocol: "https",
                          s3_region: "us-west-1",
                          url: ":s3_domain_url", 
                          s3_credentials: { access_key_id: ENV["AWS_KEY"], 
                                            secret_access_key: ENV["AWS_SECRET"] },
                          bucket: "daviduli-template",
                          path: "/:class/:id/:style/:basename.:extension",
                          default_url: "/:class/:id/:style/:basename.:extension",
                          default_style:  "medium"

	process_in_background :image, processing_image_url: "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/default-artwork/gears.gif"                          
                                          
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }, less_than: 3.megabytes

  def avatar
    if self.image_file_name.nil?
      return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/default-artwork/user-avatar.jpg"
    else
      return self.image.url(:mini)
    end
  end

  def custom_avatar_url 
    if self.image_file_name.nil?
      return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/default-artwork/user-avatar.jpg"
    else
      return self.image.url(:mini)
    end
  end

  def thumb
    if self.image_file_name.nil? 
      return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/default-artwork/user.jpg"
    else
      return self.image.url(:thumb)
    end
  end

  def picture
    if self.image_file_name.nil? 
      return "https://s3-us-west-1.amazonaws.com/daviduli-template/assets/default-artwork/user.jpg"
    else
      return self.image.url(:medium)
    end
  end
end
