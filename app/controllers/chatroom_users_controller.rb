class ChatroomUsersController < ApplicationController
  before_action :set_chatroom
  before_action :authenticate_user!

  # POST /chatroom_users
  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    redirect_to @chatroom, notice: "Successfully Joined the #{@chatroom.name} Chatroom."
  end
  
  # get /chatroom_users/1/destroy
  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: "Successfully Left the #{@chatroom.name} Chatroom." }
      format.json { render json: { url: chatrooms_url }, status: 202 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    # Only allow a trusted parameter "white list" through.
    def chatroom_user_params
      params.require(:chatroom_user).permit(:chatroom_id, :user_id)
    end
end
