class AddPictureInActivities < ActiveRecord::Migration
  def change
    add_column(:activities, :picture_path, :varchar)
  end
end
