class AddDetailAddr < ActiveRecord::Migration
  def change
    add_column(:activities, :detail_addr, :varchar)
  end
end
