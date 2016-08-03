class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_invite_params, only: [:create]
  before_action :configure_accept_invitation_params, only: [:update]

  # GET /resource/invitation/new
  def new
    super
  end

  # POST /resource/invitation
  def create
    super
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    super
  end

  # PUT /resource/invitation
  def update
    super
  end

  protected

  # def after_invite_path_for(inviter, invitee = nil)
  #   finalize_invitation_user_path(inviter)
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_invite_params
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :name, :username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_accept_invitation_params    
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :username, :image, :password, :password_confirmation, :invitation_token])
  end
  
end