class UsersAddColumn < ActiveRecord::Migration
  def change
    add_column(:users, :readed, :text)
    add_column(:users, :unreaded, :text)
  end
end
