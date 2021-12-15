class AddLieuxFaitsToSignalements < ActiveRecord::Migration[6.1]
  def change
    add_column :signalements, :lieux_faits, :string
  end
end
