class ChangeDateFormatInGoals < ActiveRecord::Migration
  def self.up
   change_column :goals, :startdate, :date
   change_column :goals, :enddate, :date
  end

  def self.down
   change_column :goals, :startdate, :datetime
   change_column :goals, :enddate, :datetime
  end
end
