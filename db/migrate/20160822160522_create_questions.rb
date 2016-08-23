class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.date :event_date

      t.timestamps
    end
  end
end
