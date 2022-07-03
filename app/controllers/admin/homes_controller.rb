class Admin::HomesController < ApplicationController
  def top
    @orders=Order.page(params[:page]).per(11)
  end
end
