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
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item has been created!"
      redirect_to store_items_path
    else
      flash.now[:errors] = @item.errors.full_messages.join(", ")
      render :new
    end
  end
  
  def edit 
    @item = current_user.store.items.find(params[:id])
    @categories = Category.all
  end
  
  def update
    @item = current_user.store.items.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item has been updated!"
      redirect_to store_items_path
    else
      flash.now[:errors] = @item.errors.full_messages.join(", ")
      render :edit
    end
  end
  
  def destroy
    item = current_user.store.items.find(params[:id])
    if item.bids.empty?
      item.delete
      flash[:success] = "Item has been deleted!"
      redirect_to store_items_path
    else
      flash[:errors] = "That item has bids! It can't be deleted."
      redirect_to store_items_path
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, 
                                 :description, 
                                 :active,
                                 :starting_price, 
                                 :expiration_date, 
                                 :attachment, 
                                 :category_id, 
                                 :store_id)
  end
end
