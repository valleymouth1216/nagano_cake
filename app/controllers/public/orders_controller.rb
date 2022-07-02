class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def confirm
   # binding.pry #追記する
   if params[:order][:select_address]=="0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
   elsif params[:order][:select_address]=="1"
     @order = Order.new(order_params)
     @address = Address.find(params[:order][:address_id])
     @order.postal_code = @address.postal_code
     @order.address = @address.address
     @order.name = @address.name
   else
    @order = Order.new(order_params)
    @order.postal_code=params[:order][:postal_code]
    @order.address=params[:order][:address]
    @order.name=params[:order][:name]
   end
    @cart_items=current_customer.cart_items
    @total=0
    @shipping_cost=800

  end

  def create
     # binding.pry #追記する
      @order = Order.new(order_params)
      @order.save
      @cart_items=current_customer.cart_items
      @cart_items.each do |cart_item|
        order_details=OrderDetail.new
        order_details.order_id=@order.id
        order_details.item_id=cart_item.item_id
        order_details.price=cart_item.item.price
        order_details.amount=cart_item.amount
        order_details.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_complete_path
  end

  def complete

  end

  def index
  end

  def show
  end




private
def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name,:total_payment,:shipping_cost,:customer_id)
end
end
