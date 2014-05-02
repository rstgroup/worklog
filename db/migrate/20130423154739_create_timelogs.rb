class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.integer :part_id
      t.integer :user_id
      t.text :description
      t.integer :duration
      t.date :worked_on
    end
    add_index :timelogs, :part_id
    add_index :timelogs, :user_id
  end
end
