class ChangeUsersEntityContraint < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :entity_id, :bigint, null: true
  end
end
