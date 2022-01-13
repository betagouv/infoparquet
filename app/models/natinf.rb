class Natinf < ApplicationRecord
    has_and_belongs_to_many :signalements

    validates :numero, format: { with: /\A[0-9]+\z/, message: "'${value}' n'est pas un numéro NATINF valide" }
end
