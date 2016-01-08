class CreateCommentActivities < ActiveRecord::Migration
  def change
    create_table :comment_activities do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :activity_id
      t.text :content

      t.timestamps null: false
    end
  end
end
