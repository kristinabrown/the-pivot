class Stores::ItemsController < Stores::StoresController
  
  def index
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
    @categories = Category.all
  end
  
  def create
    require 'pry'; binding.pry
  end
  
end
