class AddColumn < ActiveRecord::Migration
  def change
    add_column(:activities, :province, :varchar)
    add_column(:activities, :district, :varchar)
    rename_column(:activities, :place, :city)
  end
end
