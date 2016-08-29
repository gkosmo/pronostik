class Question < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category
  has_many :questions_users_pendings, dependent: :destroy

  #creating questions with many scenarios

  accepts_nested_attributes_for :scenarios

  def name
    self.content
  end

end
