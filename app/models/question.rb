class Question < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category

  def name
    self.content
  end

end
