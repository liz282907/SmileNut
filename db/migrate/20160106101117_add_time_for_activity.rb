class AddTimeForActivity < ActiveRecord::Migration
  def change
    add_column :activities,:start_time,:time
    add_column :activities,:end_time,:time
  end
end
