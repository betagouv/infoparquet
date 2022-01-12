class AddUniqeIndexToNataffCode < ActiveRecord::Migration[6.1]
  def change
    add_index :nataffs, :code, unique: true
  end
end
