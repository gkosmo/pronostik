class AddContentToScenario < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :content, :text
  end
end
