class Nataff < ApplicationRecord
    has_and_belongs_to_many :signalements

    validates :code, format: { with: /\A[A-Z][0-9]?[0-9]?\z/, message: "'%{value}' n'est pas un code NATAFF valide" }
end
