class Scenario < ApplicationRecord
  belongs_to :question
  has_many :bets, dependent: :destroy

  validates :content, length: { maximum: 200, too_long: '%{count} is the max number of characters'}
end
