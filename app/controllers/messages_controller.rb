class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_chatroom

  # POST /messages
  def create
    @message = @chatroom.messages.new(message_params)

    if @message.save
      redirect_to @message.chatroom, notice: 'Message was sent successfully.'
    else
      redirect_to @message.chatroom, notice: 'Message failed to send.'
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to @message.chatroom, notice: 'Message was successfully destroyed.'
  end

  private
    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:user_id, :chatroom_id, :body)
    end
end
