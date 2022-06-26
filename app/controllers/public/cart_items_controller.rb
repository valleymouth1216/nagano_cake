class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  
  def index
  end

  def create
    #binding.pry
    #@item=Item.find(cart_item_params[:item_id])
   @cart_item=CartItem.new(cart_item_params)
   @cart_item.customer_id=current_customer.id
   @cart_item.save
   redirect_to cart_items_path
  end

    private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
