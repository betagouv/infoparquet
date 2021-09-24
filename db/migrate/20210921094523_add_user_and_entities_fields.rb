class AddUserAndEntitiesFields < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nom, :string, null: false
    change_column :users, :prenom, :string, null: false
    change_column :users, :entity_id, :bigint, null: false

    rename_column :entities, :type, :service
    add_column :entities, :departement, :string, null: false

    change_column :signalements, :demandeur_id, :bigint, null: false
  end
end
