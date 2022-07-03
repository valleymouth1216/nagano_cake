class Order < ApplicationRecord
  belongs_to :customer
  has_many:order_details,dependent: :destroy

    validates :postal_code, presence: true,numericality: true
    validates :address, presence: true
    validates :name, presence: true

    def delivery_address
     '〒' + postal_code + ' ' + address
    end




  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: {waiting_payment: 0, confirmation_payment: 1, in_production: 2, preparing_shipping: 3, shipped: 4 }
end
