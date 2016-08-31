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
    @randque = Question.all.sample(30)
    @randque_not_voted = []
    @randque.each do |que|
      if que.bets.where(user_id: current_user.id).empty? && que.event_date < DateTime.now.to_date
        @randque_not_voted << que
      end
    end
    @randque_not_voted = @randque_not_voted.sample(4)
  end
end
