class Bet < ApplicationRecord
  has_many :just_upvotes
  belongs_to :user
  belongs_to :scenario
end
