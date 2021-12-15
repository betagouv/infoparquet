class RemoveAdminServiceFk < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :administration_service, foreign_key: true
  end
end
