class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new

  end

  def create
    @item=Item.new(item_params)
    if @item.save
    redirect_to admin_items_path
    flash[:notice] = "商品追加しました."
    else
    render :new
    end
  end


  def show
    @item=Item.find(params[:id])
  end

  def edit
     @item=Item.find(params[:id])
  end

  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
    redirect_to admin_item_path(@item.id)
    flash[:notice] = "商品内容更新しました."
    else
    render :edit
    end
  end
    private

  def item_params
    params.require(:item).permit(:name,:introduction,:price,:is_active,:image,:genre_id)
  end
end
