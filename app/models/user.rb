class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :demandes, class_name: 'Signalement', foreign_key: 'demandeur_id'
  has_many :instructions, class_name:'Signalement', foreign_key: 'instructeur_id'

  enum role: {
     root: 0,
     manager: 1,
     user: 2
  }, _prefix: true
end
