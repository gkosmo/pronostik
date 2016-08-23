class QuestionsController < ApplicationController
  before_action :set_question

  def index
    @questions = Question.all
  end

  def show
    @bet = Bet.new

    @scenarios = @question.scenarios
    @bets = @question.bets
    @justifications_and_source = @bets.where.not(justification: nil)

    @existing_bet = current_user.bets.
      joins(scenario: :question).
      where(questions: { id: @question.id }).
      first

    @choosen_scenario = @existing_bet.scenario unless @existing_bet.nil?

    @certainties = []
    @bets.each do |bet|
      @certainties << bet.estimation
    end
    @certainties
    @average_certainty = @certainties.inject{ |s, e| s + e }.to_f / @certainties.size


  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end
