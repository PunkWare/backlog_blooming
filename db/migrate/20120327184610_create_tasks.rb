class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :code
      t.string :title
      t.integer :remaining_effort

      t.timestamps
    end
    
    add_index :tasks, [:user_id, :code]
  end
end
