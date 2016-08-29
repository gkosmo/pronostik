class Question < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category

  def name
    self.content
  end

  def question_created_at
    self.created_at.to_date
  end


end
