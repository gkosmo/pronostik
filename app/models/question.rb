class Question < ApplicationRecord
 include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  searchkick
  has_many :scenarios, dependent: :destroy
  has_many :bets, through: :scenarios
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :category
  has_many :questions_users_pendings, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 200, too_long: '%{count} is the max number of characters'}
  validates :category, presence: true
  validates :event_date, presence: true
  #validate :force_four_scenarios


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

  def force_four_scenarios
    result = []
    self.scenarios.each do |scenario|
      if scenario.content != ""
        result << true
      else
        result << false
      end
    end
    errors.add(:base, "must be at least 4 scenarios, currently there are #{result.partition {|value| value}.first.count}. Return to previous page") if result.include?(false)
  end
end
