class AddUserColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :administration, :string, null: true
    add_column :users, :service, :string, null: true
    add_column :users, :telephone, :string, null: true
    remove_column :users, :entity_id

    drop_table :entities
  end
end
