class Bet < ApplicationRecord
  has_many :just_upvotes
  belongs_to :user
  belongs_to :scenario

  validates :justification, length: { maximum: 3000, too_long: '%{count} is the max number of characters'}

  def compute_score(scenario, question)
    puts "y"
    return unless question.happened

    happened_scenario = question.scenarios.where(happened: true).first
    number_of_bets = question.bets.count
    correct_bets = happened_scenario.bets.count
    p happened_scenario
    #average_certainty = scenario_average_certainty(happened_scenario)
    certainties = []
    happened_scenario.bets.each do |bet|
      certainties << bet.estimation
    end

    average_certainty = certainties.inject { |sum, certainty| sum + certainty } / correct_bets

    puts "y"
    p average_certainty

    if self.scenario == happened_scenario
      self.scenario_score = (100 - ((correct_bets / number_of_bets.to_f * 100)) + (self.estimation - average_certainty))
    else
      if self.estimation < average_certainty
        self.scenario_score = (self.estimation - average_certainty)
      else
        self.scenario_score = (self.estimation - average_certainty)
      end
    end
  end

  private

  # SCORE COMPUTATION METHODS (begin)
  def scenario_average_certainty(happened_scenario)
    result.certainty
          happened_scenario.
          select("AVG(estimation) AS certainty").
          joins(:bets).
          group("scenarios.id").
          limit(1).
          first.
          certainty
  # SCORE COMPUTATION METHODS (end)
  end
end

