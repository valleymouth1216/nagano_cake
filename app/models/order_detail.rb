class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: {cannotbe_manufactured: 0, waiting_production: 1, in_production: 2, production_completed: 3}
end
