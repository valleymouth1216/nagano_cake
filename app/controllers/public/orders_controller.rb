class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :order_new?, only: [:new,]
  
  def new
    @order=Order.new
  end

  def confirm
   # binding.pry #追記する
    @cart_items=current_customer.cart_items
    @total=0
    @shipping_cost=800
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
    @address=Address.new
    @address.postal_code=params[:order][:postal_code]
    @address.address=params[:order][:address]
    @address.customer_id=current_customer.id
    @address.name=params[:order][:name]
    if @address.save
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
    else
      render:new, status: :unprocessable_entity
    end
   end


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
    @orders=current_customer.orders.page(params[:page]).per(10)
  end

  def show
    @order=current_customer.orders.find(params[:id])
    @order_details=OrderDetail.where(order_id: @order.id)
    @order_total=0
  end




private

def order_new?
  redirect_to cart_items_path, notice: "カートに商品を入れてください" if current_customer.cart_items.blank?
end

def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name,:total_payment,:shipping_cost,:customer_id)
end
end
