class Signalement < ApplicationRecord
    belongs_to :createur, class_name: 'User', foreign_key: 'createur_id', required: true
    belongs_to :administration, required: true

    has_and_belongs_to_many :nataffs
    has_and_belongs_to_many :natinfs

    has_many_attached :documents

    default_scope { includes(:createur, :administration, :nataffs, :natinfs) }

    enum status: {
        draft: 0,
        sent: 1,
        closed: 2
    }
end
