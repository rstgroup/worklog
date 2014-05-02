class ChangeDurationTypeToFloatInTimelogs < ActiveRecord::Migration
  def change
    change_column :timelogs, :duration, :float
  end
end
