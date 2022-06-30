class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!


  def index
    @cart_items=current_customer.cart_items
  #  @cart_items=CartItem.all
    @total=0
  end

  def create
    #binding.pry
   #@item=Item.find(cart_item_params[:item_id])
   @cart_item=CartItem.new(cart_item_params)
   @cart_item.customer_id=current_customer.id
   if @current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
     @cart_item = @current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
     @cart_item.amount += params[:cart_item][:amount].to_i
     if @cart_item.save
     flash[:notice] = "商品の個数が変更されました！"
     else
       flash[:notice] = "1つの種類の商品は10個以上ご注文いただけません。"
       redirect_to  item_path(@cart_item.item_id) and return
     end
   else
      @cart_item.save
       flash[:notice] = "カートに商品が追加されました！"
   end
    redirect_to cart_items_path and return
  end

  def destroy
    cart_item=CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
    flash[:notice] = "1つの商品をカートから削除しました."
  end

   def destroy_all
     current_customer.cart_items.destroy_all
     redirect_to cart_items_path
     flash[:notice] = "カートを空にしました."
   end

   def update
     @cart_item=current_customer.cart_items.find(params[:id])
     @cart_item.update(amount: params[:cart_item][:amount])
     redirect_to cart_items_path
     flash[:notice] = "数量を変更しました。"
   end
    private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
