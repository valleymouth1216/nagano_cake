class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, numericality: {less_than_or_equal_to: 100}

  def subtotal
    item.with_tax_price * amount
  end


end
