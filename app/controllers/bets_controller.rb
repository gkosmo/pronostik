class BetsController < ApplicationController
  before_action :set_question, only: [:create, :update]

  def new
  end

  def create
    @bet = Bet.new(bet_params)
    @bet.user_id = current_user.id
    @bet.save
     QuestionsUsersPending.destroy_all(user_id: current_user.id,question_id: @bet.scenario.question.id)
    redirect_to question_path(@question)
  end

  def update
    @bet = current_user.bets.find(params[:id])
    @bet.update(bet_params_update)
    redirect_to question_path(@question)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def bet_params
    params.require(:bet).permit(:scenario_id, :estimation)
  end
  def bet_params_update
    params.require(:bet).permit(:justification, :Url)
  end
end
