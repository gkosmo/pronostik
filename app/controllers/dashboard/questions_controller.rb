class Dashboard::QuestionsController < ApplicationController
  before_action :set_randque
  before_action :question_params, only: [:create]


  def index
    @user = current_user
    @pending_queries = QuestionsUsersPending.where(user_id: current_user.id)
    @queries = []
    @pending_queries.each do |q|
        @queries << Question.find_by_id(q.question.id)
    end
  end

  def new
    @question = Question.new
    4.times { @question.scenarios.build}
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.scenarios.each do |scene|
      if scene.content.empty?
        scene.destroy
      end
    end
    @question.save!
    redirect_to question_path(@question)
  end


  private

   def set_randque
    @randque = Question.all.sample(30)
    @randque_not_voted = []
    @randque.each do |que|
      if que.bets.where(user_id: current_user.id).empty? && que.event_date < DateTime.now.to_date
        @randque_not_voted << que
      end
    end
    @randque_not_voted = @randque_not_voted.sample(4)   end
   def question_params
      params.require(:question).permit(:content, :category_id, :event_date, scenarios_attributes: [:id, :content])
   end
end
