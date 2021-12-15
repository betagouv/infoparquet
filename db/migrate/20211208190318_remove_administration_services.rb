class RemoveAdministrationServices < ActiveRecord::Migration[6.1]
  def change
    drop_table :administration_services
  end
end
