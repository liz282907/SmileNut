class ChangeType < ActiveRecord::Migration
  def change
    add_column :activities,:start_time,:datetime
    add_column :activities,:end_time,:datetime
 
  end
end
