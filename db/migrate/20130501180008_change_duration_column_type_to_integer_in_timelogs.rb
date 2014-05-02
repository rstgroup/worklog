class ChangeDurationColumnTypeToIntegerInTimelogs < ActiveRecord::Migration
  def change
    change_column :timelogs, :duration, :integer
  end
end
