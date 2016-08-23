class Dashboard::HistoriesController < ApplicationController

  def index
    @user = current_user
    @queries = []
   current_user.questions.each do |que|
     @queries << que if que.event_date < DateTime.now.to_date
   end
   end

end
