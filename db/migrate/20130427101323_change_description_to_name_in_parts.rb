class ChangeDescriptionToNameInParts < ActiveRecord::Migration
  def change
    rename_column :timelogs, :description, :name
  end
end
