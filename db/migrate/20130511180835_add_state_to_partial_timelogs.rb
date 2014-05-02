class AddStateToPartialTimelogs < ActiveRecord::Migration
  def change
    add_column :partial_timelogs, :status, :string, default: "initialized"
  end
end
