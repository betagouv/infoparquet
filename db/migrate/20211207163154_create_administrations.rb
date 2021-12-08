class CreateAdministrations < ActiveRecord::Migration[6.1]
  def change
    create_table :administrations do |t|
      t.string :code
      t.string :nom

      t.timestamps
    end
  end
end
