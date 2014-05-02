class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end

    add_index :parts, :project_id
  end
end
