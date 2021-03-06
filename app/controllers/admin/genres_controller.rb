class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    @genres=Genre.all
    @genre=Genre.new(genre_params)
    if @genre.save
    redirect_to admin_genres_path
    flash[:notice] = "ジャンル追加しました."
    else
    render :index
    end
  end  
  
  def index
    @genres = Genre.all
    @genre =Genre.new
  end

  def edit
    @genre=Genre.find(params[:id])
  end
  
  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
    redirect_to admin_genres_path
    flash[:notice] = "ジャンル更新しました."
    else
    render :edit
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
