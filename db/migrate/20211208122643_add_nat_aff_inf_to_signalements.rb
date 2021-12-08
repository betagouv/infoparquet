class AddNatAffInfToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_column :signalements, :nataff, :string
    add_column :signalements, :natinf, :string
  end
end
