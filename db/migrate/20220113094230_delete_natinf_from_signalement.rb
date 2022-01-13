class DeleteNatinfFromSignalement < ActiveRecord::Migration[6.1]
  def change
    remove_column :signalements, :natinf
  end
end
