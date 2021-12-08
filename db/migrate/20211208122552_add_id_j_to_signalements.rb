class AddIdJToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_column :signalements, :idj, :string
  end
end
