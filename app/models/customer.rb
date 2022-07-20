class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses,dependent: :destroy
  has_many:cart_items,dependent: :destroy
  has_many:orders,dependent: :destroy
  has_many:order_details,dependent: :destroy
  
  
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
    validates :email, presence: true,uniqueness: true
    validates :first_name, presence: true    
    validates :postal_code, presence: true,numericality: true
    validates :address, presence: true
    validates :telephone_number, presence: true,numericality: true

def full_name
  last_name+first_name
end
end
