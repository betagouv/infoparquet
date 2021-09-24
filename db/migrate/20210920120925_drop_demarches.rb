class DropDemarches < ActiveRecord::Migration[6.1]
  def change
    drop_table :demarches
  end
end
