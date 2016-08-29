class BetsController < ApplicationController
  before_action :set_question, only: [:create, :update]

  def index
    @users = User.all

    #total score by users
    @scores = []
    @statistics = []
    @users_name = []

    @users.each do |user|
      @users_name << user.first_name
      user.bets.each do |bet|
        if bet.scenario_score.nil?
          @scores << 0
        else
          @scores << bet.scenario_score
        end
      end
      @statistics << @scores.inject { |sum, el| sum + el } unless @scores.nil?
    end
    @users_name
    @statistics
    @final_hash = Hash[@users_name.zip(@statistics)]

    #score per week per users
    @index = 0


  end



  def new
  end

  def create
    @bet = Bet.new(bet_params)
    @bet.user_id = current_user.id
    @bet.save
    if @question.status == 'new'
      @question.bets.count > 20
      @question.status = 'good'
      @question.save
    end
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
