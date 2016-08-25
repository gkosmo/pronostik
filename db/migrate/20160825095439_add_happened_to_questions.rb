class AddHappenedToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :happened, :boolean
  end
end
