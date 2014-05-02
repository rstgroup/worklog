class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :client_id, null: false, default: 0, foreign_key: false
      t.timestamps
    end

    add_index :projects, :client_id
  end
end
