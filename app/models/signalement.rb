class Signalement < ApplicationRecord
    belongs_to :demandeur, class_name: 'User', foreign_key: 'demandeur_id'
    belongs_to :instructeur, class_name: 'User', foreign_key: 'instructeur_id', optional: true
end
