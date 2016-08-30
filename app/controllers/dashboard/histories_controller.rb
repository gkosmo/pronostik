class Dashboard::HistoriesController < ApplicationController
  before_action :set_randque


  def index
    @user = current_user
    @queries = []
    @today = false
    current_user.questions.each do |que|
      @queries << que if que.event_date < DateTime.now.to_date
      @today = true if que.event_date == DateTime.now.to_date
    end
  end


  private

   def set_randque
     @randque = Question.all.sample(3)
   end

end
