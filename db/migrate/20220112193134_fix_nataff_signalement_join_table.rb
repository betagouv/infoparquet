class FixNataffSignalementJoinTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :signalements_nataffs
    create_table :nataffs_signalements, id: false do |t|
        t.belongs_to :signalement
        t.belongs_to :nataff
    end
  end
end
