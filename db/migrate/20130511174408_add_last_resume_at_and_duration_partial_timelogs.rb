class AddLastResumeAtAndDurationPartialTimelogs < ActiveRecord::Migration
  def change
    add_column :partial_timelogs, :last_resume_at, :datetime
    add_column :partial_timelogs, :duration, :integer
  end
end
