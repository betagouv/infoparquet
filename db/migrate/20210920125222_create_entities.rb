class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :type

      t.references :parent, foreign_key: { to_table: :entities }

      t.timestamps
    end

    add_reference :users, :entity, index: true
  end
end
