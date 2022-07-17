class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
  def show
    @order=Order.find(params[:id])
    @order_details=OrderDetail.where(order_id: @order.id)
    @total=0
  end

  def update
    @order=Order.find(params[:id])
    @order_details=OrderDetail.where(order_id: @order.id)
    @order.update(order_params)
    #  binding.pry
    if @order.order_status=="confirmation_payment"
      @order_details.update(making_status: 1)
    end
    redirect_to admin_order_path(@order.id)
      flash[:notice] = "注文ステータス更新しました."
  end

  private

  def order_params
  params.require(:order).permit(:order_status)
  end
end
