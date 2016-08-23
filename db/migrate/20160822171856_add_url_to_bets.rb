class AddUrlToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :Url, :string
  end
end
