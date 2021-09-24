class AddFkUserEntity < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :users, :entities
  end
end
