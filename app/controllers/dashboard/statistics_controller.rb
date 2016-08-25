class Dashboard::StatisticsController < ApplicationController
  before_action :set_randque

  def index

    @user = current_user

    # FC score and question score
    @fc_score = @user.bets.sum(:scenario_score)

    # @fc_score = 0
    # @user.bets.each do |bet|
    #   @fc_score += bet.scenario_score
    # end
    # @fc_score

    # Number of bets per category
    @results = @user.bets.
      select("categories.title, COUNT(bets.id) AS bets_count").
      joins(scenario: { question: :category }).
      group("categories.id")

    @bets_per_cat = @results.map { |category| [category.title, category.bets_count] }

    # Number of successful bets per category
    @results_2 = @user.bets.
      select("categories.title, COUNT(bets.id) AS bets_count").
      joins(scenario: { question: :category }).
      where(scenarios: {happened: true}).
      group("categories.id")


    #accuracy per category
    @number_bets_per_cat = @results.map { |category| [category.title, category.bets_count] }

    @success_bets_per_cat = @results_2.map { |category| [category.title, category.bets_count] }

    @name_bets_per_cat = @results.map { |category| [category.title] }

    if @number_bets_per_cat.size != @success_bets_per_cat.size
      @number_bets_per_cat.keep_if { |element| element[0] == @success_bets_per_cat.flatten[0] }
    end

      @new_array = []
      @success_bets_per_cat.each do |element|
        @new_array << element[1]
      end

      @new_array_2 = []
      @number_bets_per_cat.each do |element|
        @new_array_2 << element[1]
      end

      @final_array = []
      @index = 0
      @new_array.each do |element|
        @final_array << (element.to_f / @new_array_2[@index] * 100).round
        @index += 1
      end

      @accuracy_per_cat = Hash[@name_bets_per_cat.flatten.zip @final_array]

    #Total Accuracy : successful bets / total bets
    @successful_bets = @user.bets.joins(:scenario).where(scenarios: {happened: true}).count
    @total_bets = @user.bets.count
    @accuracy = @successful_bets / @total_bets * 100

    #recommendation
    @sorted = @success_bets_per_cat.sort_by { |element| element[1]}
    @recommendation = @sorted[0][0]

    #accuracy per month
    # @successful_bets = @user.bets.joins(:scenario).where(scenarios: {happened: true}).group("DATE_TRUNC('month', created_at)").count
    # @total_bets = @user.bets.group("DATE_TRUNC('month', created_at)").count
  end


  private
  def set_randque
    @randque = Question.all.sample(10)
  end
end


















