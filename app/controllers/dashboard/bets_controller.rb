class Dashboard::BetsController < ApplicationController
  before_action :set_randque

  def index
    @bets = current_user.bets
    @bets = @bets.paginate(:page => params[:page])
  end

private

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
