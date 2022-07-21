class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index,:show]


  def index
    @items =Item.page(params[:page]).per(8)
    @items_count =Item.all
    @genres=Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items= @genre.items.page(params[:page]).per(8)
      @items_count =Item.all
    end
  end


  def show
    @genres=Genre.all
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
  end


end
