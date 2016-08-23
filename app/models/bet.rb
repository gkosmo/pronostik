class Bet < ApplicationRecord
  has_many :just_upvotes
  belongs_to :user
  belongs_to :scenario

  validates :justification, length: { maximum: 2000, too_long: '%{count} is the max number of characters'}
end
