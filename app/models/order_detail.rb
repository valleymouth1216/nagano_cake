class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: {cannotbe_manufactured: 0, waiting_production: 1, in_production: 2, production_completed: 3}

   def order_with_tax_price
    (price* 1.1).floor
   end
   
   def order_subtotal
    order_with_tax_price*amount
   end

end
