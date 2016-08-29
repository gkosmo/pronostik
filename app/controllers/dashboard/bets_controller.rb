class Dashboard::BetsController < ApplicationController
  before_action :set_randque

  def index
    @bets = current_user.bets
    @bets = @bets.paginate(:page => params[:page])
  end

private

 def set_randque
   @randque = Question.all.sample(10)
 end


end
