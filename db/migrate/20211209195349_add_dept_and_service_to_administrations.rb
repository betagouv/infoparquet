class AddDeptAndServiceToAdministrations < ActiveRecord::Migration[6.1]
  def change
    add_column :administrations, :departement, :integer
    add_column :administrations, :service, :string 
  end
end
