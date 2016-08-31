class BetsController < ApplicationController
  before_action :set_question, only: [:create, :update]

  def index
    @users = User.all
    @final_hash = {}
    #total score by users

    @statistics = []
    @users_name = []

    @users.each do |user|
      @final_hash[user] = []
      @scores_bets = []
      @scores_justification = []
      @users_name << user.first_name
      user.bets.each do |bet|
        if bet.scenario_score.nil?
          @scores_bets << 0
          @scores_justification << 0
        else
          @scores_bets << bet.scenario_score
          @scores_justification << bet.just_upvotes.count unless bet.justification.nil?
        end
      end
       @final_hash[user] << @scores_bets.inject { |sum, el| sum + el } unless @scores_bets.nil?
       @final_hash[user] << @scores_justification.inject { |sum, el| sum + el } unless @scores_justification.nil?
       sum = 0
       user.questions.each do |q|
         sum += q.bets.count
       end
       @final_hash[user] << sum

    end
    @final_hash = @final_hash.sort_by {|k, v| v[0] }.reverse!
    #score per week per users
    @index = 0
    @final_hash
  end



  def new
  end

  def create
    @bet = Bet.new(bet_params)
    @bet.user_id = current_user.id
    @bet.save
    if @question.status == 'new'
      @question.bets.count > 5
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
