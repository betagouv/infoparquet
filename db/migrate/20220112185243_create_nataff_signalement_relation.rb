class CreateNataffSignalementRelation < ActiveRecord::Migration[6.1]
  def change
    create_table :signalements_nataffs, id: false do |t|
        t.belongs_to :signalement
        t.belongs_to :nataff
    end
  end
end
