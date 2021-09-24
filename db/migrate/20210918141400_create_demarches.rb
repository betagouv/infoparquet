class CreateDemarches < ActiveRecord::Migration[6.1]
  def change
    create_table :demarches do |t|
      t.date :date_depot
      t.string :demandeur_email
      t.string :demandeur_civilite
      t.string :demandeur_prenom
      t.string :demandeur_nom
      t.string :administration
      t.string :service
      t.string :departement
      t.string :type_contentieux
      t.boolean :urgence
      t.text :motif_signalement
      t.string :reference_administration
      t.text :commentaire

      t.timestamps
    end
  end
end
