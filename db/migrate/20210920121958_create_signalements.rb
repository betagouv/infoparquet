class CreateSignalements < ActiveRecord::Migration[6.1]
  def change
    create_table :signalements do |t|
      t.string :type
      t.boolean :urgence
      t.text :motif
      t.string :reference_administration
      t.text :commentaire
      t.string :reference_juridiction

      t.references :demandeur, foreign_key: { to_table: :users }
      t.references :instructeur, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
