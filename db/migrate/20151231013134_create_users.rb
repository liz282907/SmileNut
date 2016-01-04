class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Sex
      t.string :Password
      t.text :Tag
      t.text :In_Activity
      t.text :Sponsor_Activity
      t.string :Telephone

      t.timestamps null: false
    end
  end
end
