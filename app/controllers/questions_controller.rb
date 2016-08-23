class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end
  def show
    @bet = Bet.new
    @scenarios = @question.scenarios
    @bets = []
    @scenarios.each do |scenario|
      @bets = scenario.bets
      @bets.flatten
    end

    @justifications = []
    @bets.each do |bet|
      @justification << bet.justification
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end
end
