class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references :user, foreign_key: true
      t.references :scenario, foreign_key: true
      t.integer :estimation
      t.float :scenario_score
      t.text :justification

      t.timestamps
    end
  end
end
