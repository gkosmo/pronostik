class Questions::ComputeBetScoresService
  def initialize(question)
    @question = question
  end

  def call
    @happened_scenario = @question.scenarios.where(happened: true).first

    @question.bets.each do |bet|
      score = compute_score(bet)
      bet.update(scenario_score: score)
      #add to stats
    end
  end

  private

  def compute_score(bet)
    # TODO ici prendre code de Sean
    return 100
  end
end
