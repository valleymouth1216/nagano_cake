class Public::CustomersController < ApplicationController
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
    @customer.update(customer_params)
    redirect_to customers_my_page_path
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
