class Question < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category

  has_many :questions_users_pendings, dependent: :destroy

  #creating questions with many scenarios
  after_initialize :assign_defaults
  attr_accessor :status
  accepts_nested_attributes_for :scenarios

  def name
    self.content
  end
  def up_status
    self.status = 'good'
    self.save
  end
  private

  def assign_defaults
    # required to check an attribute for existence to weed out existing records
    self.status = 'new'
  end

  def question_created_at
    self.created_at.to_date
  end


end
