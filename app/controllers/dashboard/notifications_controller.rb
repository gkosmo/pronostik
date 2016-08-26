class Dashboard::NotificationsController < ApplicationController
  before_action :set_randque
  before_action :set_notif, only: :destroy
  def index
    @notifs = current_user.notifications
  end


  def destroy
  @notif.destroy
  redirect_to dashboard_notifications_path
end

private
def set_notif
  @notif = Notification.find(params[:id])
end


 def set_randque
   @randque = Question.all.sample(10)
 end


end
