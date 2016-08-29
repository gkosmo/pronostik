class Question < ApplicationRecord
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category
  after_initialize :assign_defaults
  attr_accessor :status
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

end
