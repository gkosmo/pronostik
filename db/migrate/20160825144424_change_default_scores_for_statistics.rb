class ChangeDefaultScoresForStatistics < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:statistics, :fc_score, 0)
    change_column_default(:statistics, :query_score, 0)
  end
end
