class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_question, only: [:show]
  before_action :set_randque, only: [:show]
  before_action :set_expired_question, only[:new_index, :good_index]

  def new_index
    @searched = Question.all
    @searched = @searched.where(created_at: 10.days.ago..DateTime.now.to_date)
    @searched_questions = []
    @searched.each do |x|
      @searched_questions << x if x.bets.count < 10
    end
      @top_tags = Tag.select("tags.title, COUNT(questions.id) AS questions_count").
          joins(:questions).
          group("tags.id").
          order("questions_count DESC").
          limit(7)
  end

  def good_index
        @top_tags = Tag.select("tags.title, COUNT(questions.id) AS questions_count").
          joins(:questions).
          group("tags.id").
          order("questions_count DESC").
          limit(7)
          @searched = Question.all
          @searched = @searched.where(created_at: 10.days.ago..DateTime.now.to_date)
          @searched_questions = []
          @searched.each do |x|
            @searched_questions << x if x.bets.count >= 5
          end
  end

  def index
  #input van de search
    @search = params[:search_term] if  !params[:search_term].nil?
    @category = params[:category]
    @searched_questions = Question.all.order('id DESC')
    @top_tags = Tag.select("tags.title, COUNT(questions.id) AS questions_count").
      joins(:questions).
      group("tags.id").
      order("questions_count DESC").
      limit(7)

    if @category.present?
      @searched_questions = @searched_questions.where(category_id: params[:category]).uniq
    end
    if @search.present?
      @searched_questions = @searched_questions.joins(:tags).where("tags.title ILIKE ?", "%#{@search}%").uniq
    end
     @unbetted_questions = []
    if current_user
      @searched_questions_only_new = []
      @searched_questions.each do |question|
        if question.event_date > DateTime.now.to_date && question.bets.where(user_id: current_user.id).empty?
          @searched_questions_only_new << question
        else
          @unbetted_questions << question
        end

      end
      @right_column_current_user = @searched_questions_only_new.take(7)
    end


    @limited_questions = @searched_questions.limit(7)

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

    #resources sorted by popularity
    @resources = @bets.select("Url").group(:Url).count
    @resources = @resources.sort_by { |k, v| v }.reverse[0..4]

    @all_bets = @bets.where.not(justification: nil)
    @existing_bet = nil

    #recommendation based on weighted algoritm
    @prediction = @question.scenarios.sort_by { |scenario| scenario.bets.size }.reverse[0].content
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


    #@users = User.all.group(:country).joinwhere(bet_id: @question.id).count
    @countries = []
    @hash = {}

    @bets.each do |bet|
      @countries << bet.user.country
    end
    @countries
    @result = @countries.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }

    # @countries.each do |country|
    #   hash[country] += "1"
    # end
    # @hash


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
    @randque = Question.all.sample(30)
    @randque_not_voted = []
    @randque.each do |que|
       if que.bets.where(user_id: current_user.id).empty? && que.event_date < DateTime.now.to_date
        @randque_not_voted << que
      end
    end
    @randque_not_voted = @randque_not_voted.sample(4)
  end
  def set_expired_question
    @randque = Question.where(event_date: > 1.day.ago)
    @randque_not_voted = []
    @randque.each do |que|

    end
    @randque_not_voted = @randque_not_voted.sample(4)
  end
end
