class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :read, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin, only: [:new, :create, :edit, :update]

  # GET /notifications
  def index
    if current_user.admin?
      @notifications = Notification.all.order(id: :desc)
      render :admin_index
    elsif params[:user_id]
      @recepient = User.find(params[:user_id])
      @notifications = @recepient.notifications.order(id: :desc).limit(25)
      redirect_to "/", :alert => "You do not have any notifications." if @notifications.count == 0
    else
      redirect_to "/", :alert => "Not Authorized."
    end
  end

  # GET /notifications/1
  def show
    if @notification.unread?
      @notification.update_attributes(read_at: DateTime.current)
    end
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)
    @notification.actor_id = current_user.id

    if @notification.save
      redirect_to notifications_url, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      redirect_to notifications_url, notice: 'Notification was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /notifications/1/read
  def read
    if current_user == @notification.recipient
      if @notification.update_attributes(read_at: DateTime.current )
        redirect_to notifications_url, notice: 'Notification was successfully updated.'
      else
        redirect_to notifications_url, alert: 'Unable to Update Notification.'
      end
    else
      redirect_to "/", :alert => "Not Authorized."
    end
  end

  def destroy
    @notification.destroy

    respond_to do |format|
      format.html { 
        if current_user.admin?
          redirect_to notifications_url, notice: 'Notification was successfully destroyed.' 
        else
          redirect_to user_notifications_url(current_user), notice: 'Notification was successfully destroyed.' 
        end
      }
      format.json { render json: { url: notifications_url }, status: 202 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:recipient_id, :user_id, :action, :notifiable_type, :notifiable_id, :color, :icon)
    end
end
