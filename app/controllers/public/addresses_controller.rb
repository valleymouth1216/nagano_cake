class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!


  def index
    @address=Address.new
    @addresses =current_customer.addresses.page(params[:page]).per(10)
  end

  def create
  @addresses=current_customer.addresses
  @address=Address.new(address_params)
  @address.customer_id=current_customer.id
    if @address.save
    redirect_to addresses_path
    flash[:notice] = "配送先登録しました."
    else
    render :index
    end
  end

  def edit
    @address=Address.find(params[:id])
  end

  def update
    @address=Address.find(params[:id])
    if @address.update(address_params)
    redirect_to addresses_path
    flash[:notice] = "配送先更新しました."
    else
    render :edit
    end
  end

  def destroy
     address=Address.find(params[:id])
     address.destroy
     redirect_to addresses_path
     flash[:notice] = "配送先1件削除しました."
  end
  private

  def address_params
    params.require(:address).permit(:name,:postal_code,:address)
  end
end
