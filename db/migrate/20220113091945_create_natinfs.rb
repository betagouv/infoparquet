class CreateNatinfs < ActiveRecord::Migration[6.1]
  def change
    create_table :natinfs do |t|
      t.string :numero
      t.text :desc

      t.timestamps

      t.index :numero, unique: true
      t.index 'lower(numero) varchar_pattern_ops'
      t.index :desc, using: 'gin', opclass: :gin_trgm_ops
    end

    create_table :natinfs_signalements, id: false do |t|
        t.belongs_to :signalement
        t.belongs_to :natinf
    end
  end
end
