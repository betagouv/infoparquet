class AddServiceRefToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :administration_service, null: false, foreign_key: true
  end
end
