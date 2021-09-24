class RenameTypeToTypeSignalement < ActiveRecord::Migration[6.1]
  def change
    rename_column :signalements, :type, :type_signalement
  end
end
