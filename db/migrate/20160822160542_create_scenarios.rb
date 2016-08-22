class CreateScenarios < ActiveRecord::Migration[5.0]
  def change
    create_table :scenarios do |t|
      t.references :question, foreign_key: true
      t.boolean :happened

      t.timestamps
    end
  end
end
