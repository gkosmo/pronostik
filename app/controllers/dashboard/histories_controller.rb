class Dashboard::HistoriesController < ApplicationController

  def index
    @user = current_user
    @queries = current_user.questions
  end
  def hist_index
    @user = current_user
    @queries = current_user.questions

  end
end
