class AddCreateurToSignalement < ActiveRecord::Migration[6.1]
  def change
    add_reference :signalements, :createur, null: false, foreign_key: {:to_table => :users}
  end
end
