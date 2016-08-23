class Dashboard::QuestionsController < ApplicationController
  before_action :set_randque


  def index
    @user = current_user
    @queries = current_user.questions
  end


  private

   def set_randque
     @randque = Question.all.sample(10)
   end
end
