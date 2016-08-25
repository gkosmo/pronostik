class RemovePendingFromQuestion < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :pending

  end
end
