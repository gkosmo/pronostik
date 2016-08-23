class Dashboard::StatisticsController < ApplicationController
  def index

    @user = current_user

    @fc_score = []
    current_user.statistics.each do |stat|
      fc_score  << stat.fc_score
    end

    @question_score = []
    current_user.statistics.each do |stat|
      question_score  << stat.query_score
    end

  end
end
