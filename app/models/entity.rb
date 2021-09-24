class Entity < ApplicationRecord
    has_many :children, class_name: 'Entity', foreign_key: 'parent_id'
    belongs_to :parent, class_name: 'Entity', optional: true
end
