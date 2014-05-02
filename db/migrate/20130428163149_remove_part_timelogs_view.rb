class RemovePartTimelogsView < ActiveRecord::Migration
  def change
    drop_view :part_timelogs
  end
end
