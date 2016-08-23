class Dashboard::QuestionsController < ApplicationController

  def index
    @user = current_user
    @queries = current_user.questions
  end
end
