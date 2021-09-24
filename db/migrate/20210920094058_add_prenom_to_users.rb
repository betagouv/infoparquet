class AddPrenomToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :prenom, :string
  end
end
