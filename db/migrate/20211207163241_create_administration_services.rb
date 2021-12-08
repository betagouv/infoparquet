class CreateAdministrationServices < ActiveRecord::Migration[6.1]
  def change
    create_table :administration_services do |t|
      t.string :nom
      t.belongs_to :administration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
