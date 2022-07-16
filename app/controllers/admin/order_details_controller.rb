class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail=OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order=Order.find(params[:order_id])
    if @order.order_details.any? {|order_detail| order_detail.making_status=="in_production"}
      @order.update(order_status: 2)
    elsif @order.order_details.all? {|order_detail| order_detail.making_status=="production_completed"}
      @order.update(order_status: 3)
    end
    redirect_to admin_order_path(params[:order_id])
  end


  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
