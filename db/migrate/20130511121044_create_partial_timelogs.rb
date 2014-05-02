class CreatePartialTimelogs < ActiveRecord::Migration
  def change
    create_table :partial_timelogs do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
