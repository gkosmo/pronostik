class CreateJustUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :just_upvotes do |t|
      t.references :bet, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
