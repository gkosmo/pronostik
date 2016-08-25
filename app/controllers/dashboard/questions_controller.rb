class Dashboard::QuestionsController < ApplicationController
  before_action :set_randque


  def index
    @user = current_user
    @pending_queries = QuestionsUsersPending.where(user_id: current_user.id)
    @queries = []
    @pending_queries.each do |q|
        @queries << Question.find_by_id(q.question.id)
    end
  end


  private

   def set_randque
     @randque = Question.all.sample(10)
   end
end
