class AddPendingToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :pending, :boolean
  end
end
