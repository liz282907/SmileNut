class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Email, :string
  end
end
