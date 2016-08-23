class Dashboard::BetsController < ApplicationController
  def index
    @bets = current_user.bets

    @randque = Question.all.sample(10)
  end

end
