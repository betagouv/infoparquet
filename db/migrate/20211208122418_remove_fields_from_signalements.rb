class RemoveFieldsFromSignalements < ActiveRecord::Migration[6.1]
  def change
    remove_column :signalements, :type_signalement, :string
    remove_column :signalements, :motif, :string
    remove_column :signalements, :reference_juridiction, :string
  end
end
