class CreateNataffs < ActiveRecord::Migration[6.1]
  def change
    enable_extension("pg_trgm")

    create_table :nataffs do |t|
      t.string :code
      t.text :desc
      t.boolean :full

      t.timestamps

      t.index 'lower(code) varchar_pattern_ops'
      t.index :desc, using: 'gin', opclass: :gin_trgm_ops
    end
  end
end
