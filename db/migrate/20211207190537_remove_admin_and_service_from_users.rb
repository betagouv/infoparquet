class RemoveAdminAndServiceFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :administration, :string
    remove_column :users, :service, :string
  end
end
