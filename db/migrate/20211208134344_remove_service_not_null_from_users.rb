class RemoveServiceNotNullFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :administration_service_id, true
  end
end
