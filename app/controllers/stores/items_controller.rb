class Stores::ItemsController < Stores::StoresController
  
  def index
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
end
