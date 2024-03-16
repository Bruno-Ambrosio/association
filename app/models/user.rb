class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  self.per_page = 50
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :validatable

  has_many :people, dependent: :nullify
end
