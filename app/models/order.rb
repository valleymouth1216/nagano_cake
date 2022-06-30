class Order < ApplicationRecord
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: {waiting_payment: 0, confirmation_payment: 1, in_production: 2, preparing_shipping: 3, shipped: 4 }
end
