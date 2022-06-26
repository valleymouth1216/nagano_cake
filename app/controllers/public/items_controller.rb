class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index]
  
  
  def index
   # @items =Item.page(params[:page]).per(8)
    @genres=Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items= @genre.items.page(params[:page]).per(8)
    # @items=@searched_films.page(params[:page])
    end
  end
#  def show
#    @book_show=Book.find(params[:id])
#    @book= Book.new
#    @userinfo=@book_show.user

  def show
    @genres=Genre.all
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
  end
  

end
