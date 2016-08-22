class CreateQuestionsTagsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_tags, id: false do |t|
      t.integer :question_id
      t.integer :tag_id
    end

    add_index :questions_tags, :question_id
    add_index :questions_tags, :tag_id
  end
end
