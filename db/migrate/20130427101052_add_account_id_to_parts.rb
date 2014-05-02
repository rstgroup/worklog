class AddAccountIdToParts < ActiveRecord::Migration
  def change
    add_column :parts, :account_id, :integer
    add_index :parts, :account_id
  end
end
