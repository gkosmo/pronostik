class JustUpvotesController < ApplicationController
  before_action :set_question, only: [:create]
  before_action :set_bet, only: [:create]

  def create
    @just_upvotes = JustUpvote.new
    @just_upvotes.user = current_user
    @just_upvotes.bet =  @bet

    @just_upvotes.save
    redirect_to question_path(@question)

  end
  private
   def set_question
    @question = Question.find(params[:question_id])
   end
   def set_bet
    @bet = Bet.find(params[:bet_id])
   end
end
