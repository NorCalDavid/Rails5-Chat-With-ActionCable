class UsersController < ApplicationController

  before_action :set_user, only: [:update, :destroy, :profile]
  before_action :authenticate_user!
  before_action :authenticate_owner, only: [:update, :destroy, :profile]

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  # GET /users/1/profile
  def profile
    @users = User.order(:name)
  end

  private

  def authenticate_owner
    unless current_user.admin? || current_user == @user
      redirect_to "/", :alert => "Access Denied - Unauthorized."
    end  
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      @user = current_user
    end
    
    redirect_to current_user, :alert => "Access denied." if @user != current_user      
  end

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
