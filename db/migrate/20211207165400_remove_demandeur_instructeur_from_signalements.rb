class RemoveDemandeurInstructeurFromSignalements < ActiveRecord::Migration[6.1]
  def change
    remove_reference :signalements, :demandeur, null: false, foreign_key: {:to_table => :users}
    remove_reference :signalements, :instructeur, null: false, foreign_key: {:to_table => :users}
  end
end
