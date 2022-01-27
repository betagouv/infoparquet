class AddStatusToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_column :signalements, :status, :integer, default: 0
  end
end
