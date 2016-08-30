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
    @question.save!
    redirect_to question_path(@question)
  end


  private

   def set_randque
     @randque = Question.all.sample(3)
   end
   def question_params
      params.require(:question).permit(:content, :category_id, :event_date, scenarios_attributes: [:id, :content])
   end
end
