class FixUserRoleEnum < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :role
    add_column :users, :role, :integer, null: false, default: 1
  end
end
