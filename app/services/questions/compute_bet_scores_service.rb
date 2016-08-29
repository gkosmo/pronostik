class Questions::ComputeBetScoresService

  def initialize(question)
    @question = question
  end

  def call
    @question.scenarios.sample.happened = true if @question.scenarios.where(happened: true).first == nil
    @happened_scenario = @question.scenarios.where(happened: true).first
    @number_of_bets    = @question.bets.count
    @correct_bets      = @happened_scenario.bets.count
    @average_certainty = compute_average_certainty

    @question.bets.each do |bet|
      score = compute_bet_score(bet)
      bet.update!(scenario_score: score)
      send_mess_bet_changed(bet)
    end

  end

  private

  def send_mess_bet_changed(bet)

  ##        TO DO !!
  user = bet.user
  mess = Notification.new(user: user, title: 'New Score')
  mess.content = "You have a new Score for the question:  #{bet.scenario.question.content} "
  mess.save!
  end


  def compute_bet_score(bet)
    if bet.scenario_id == @happened_scenario.id # id important HERE
      return 100 - ((@correct_bets / @number_of_bets.to_f * 100)) + (bet.estimation - @average_certainty)
    elsif bet.estimation < @average_certainty
      return bet.estimation - @average_certainty
    else
      return @average_certainty - bet.estimation
    end
  end

  def compute_average_certainty
    results = @happened_scenario.bets.select("AVG(estimation) AS certainty")
    results[0].certainty.to_f
    # certainties = @happened_scenario.bets.map do |bet|
    #   certainties << bet.estimation
    # end
    # return certainties.inject { |sum, certainty| sum + certainty } / @correct_bets
  end

end
