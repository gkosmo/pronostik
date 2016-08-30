class Bet < ApplicationRecord
  has_many :just_upvotes, dependent: :destroy
  belongs_to :user
  belongs_to :scenario

  validates :justification, length: { maximum: 2000, too_long: '%{count} is the max number of characters'}
  validates :estimation, presence: true
  validates :estimation, numericality: { only_integer: true }
  validates :estimation, numericality: { greater_than_or_equal_to: 0 }
  validates :estimation, numericality: { less_than_or_equal_to: 100 }

  def bet_created_at
    self.created_at.to_date
  end
end

