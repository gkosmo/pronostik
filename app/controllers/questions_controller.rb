class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_question, only: [:show]
  before_action :set_randque, only: [:index, :show]


  def index
  #input van de search
    @search = params[:search_term] if  !params[:search_term].nil?
    @category = params[:category]
    @searched_questions = Question.all.order('id DESC')

    @top_tags = Tag.select("tags.title, COUNT(questions.id) AS questions_count").
      joins(:questions).
      group("tags.id").
      order("questions_count DESC").
      limit(5)

    if @category.present?
      @searched_questions = @searched_questions.where(category_id: params[:category])
    end
    if @search.present?
      @searched_questions = @searched_questions.joins(:tags).where("tags.title ILIKE ?", "%#{@search}%")
    end
  end

  def make_pending
    @question = Question.find(params[:question_id])
    q = QuestionsUsersPending.new()
    q.user = current_user
    q.question = @question
    q.save
    redirect_to dashboard_statistics_path
  end

  def show
    @bet = Bet.new

    @scenarios = @question.scenarios
    @bets = @question.bets
    @all_bets = @bets.where.not(justification: nil)

    @existing_bet = nil

    if user_signed_in?
      @existing_bet = current_user.bets.
      joins(scenario: :question).
      where(questions: { id: @question.id }).
      first
    end
    if user_signed_in?
      @pending =  QuestionsUsersPending.where(user_id: current_user.id, question_id: @question.id)
    end
    @choosen_scenario = @existing_bet.scenario unless @existing_bet.nil?

    # computations
    @scenarios_certainties = compute_scenarios_certainties
    @bets_count = compute_bets_count

    # charts stats
    @bar_chart = @scenarios_certainties.map do |scenario|
      [scenario.content, scenario.certainty.to_f.round(2)]
    end

    @column_chart = @bets_count.map do |scenario|
      [scenario.content, scenario.bets_count]
    end
  end

  private

  def compute_bets_count
    # hash_new = {}
    # @scenarios.each do |scenario|
    #   index = 0
    #   content = scenario.content
    #   hash_new[content] = @average_certainty[index]
    #   index += 1
    # end
    # hash_new

    return @question.scenarios.
      select("scenarios.id, content, COUNT(bets.id) AS bets_count").
      joins("LEFT OUTER JOIN bets ON bets.scenario_id = scenarios.id").
      group("scenarios.id")
  end

  def compute_scenarios_certainties
    # @certainties = []
    # @individual_average_c = []
    # @scenario_name = []

    # @scenarios.each do |scenario|
    #   @scenario_name << scenario.content

    #   scenario.bets.each do |bet|
    #     @certainties << bet.estimation
    #   end
    #     @certainties = @certainties.select { |e| e if e != nil }
    #     @individual_average_c << @certainties.inject{ |s, e| s + e }.to_f / @certainties.size unless @certainties.nil?
    # end
    # @individual_average_c
    # @scenario_name

    return @question.scenarios.
    select("scenarios.id, content, AVG(estimation) AS certainty").
    joins("LEFT OUTER JOIN bets ON bets.scenario_id = scenarios.id").
    group("scenarios.id")
  end

  def set_question
    @question = Question.find(params[:id])
  end
  def set_randque
    @randque = Question.all.sample(4)
  end
end
