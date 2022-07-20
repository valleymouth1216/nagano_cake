class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    #binding.pry
   # @customer = Customer.find(params[:id])
   @customer =current_customer
  end

  def edit
    #binding.pry
    @customer=current_customer
  end

  def update
    @customer=current_customer
    if @customer.update(customer_params)
    flash[:notice] = "登録情報を更新しました。"
    redirect_to customers_my_page_path
    else
    render:edit
    end
  end

  def unsubscribe
  end

    def withdrawal
    @customer=current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to about_path
    end

  private

  def customer_params
    params.require(:customer).permit(:email,:password,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number)
  end
end
