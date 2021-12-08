class AddDateFaitsToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_column :signalements, :date_faits, :string
  end
end
