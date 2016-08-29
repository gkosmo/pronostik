class Scenario < ApplicationRecord
  belongs_to :question
  has_many :bets, dependent: :destroy
end
