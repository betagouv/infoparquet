class AddAdministrationRefToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_reference :signalements, :administration, null: false, foreign_key: true
  end
end
