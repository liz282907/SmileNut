class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :name
      t.text :content
      t.text :participant_id
      t.text :tag
      t.string :place
      t.time :start_date
      t.time :end_date
      t.integer :recommend
      t.integer :want_join
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
