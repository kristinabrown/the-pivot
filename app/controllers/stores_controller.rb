class StoresController < ApplicationController
  
  def index
    @stores = Store.all
  end
  
  def new
    @store = Store.new
  end
  
  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "Store was successfully created."
      redirect_to stores_path
    else
      flash.now[:errors] = @store.errors.full_messages.join(", ")
      render :new
    end
  end
  
  def edit
    @store = Store.find(params[:id])
  end
  
  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      flash[:success] = "Store was successfully updated."
      redirect_to stores_path
    else
      flash.now[:errors] = @store.errors.full_messages.join(", ")
      render :edit
    end
  end
  
  def destroy
    store = Store.find(params[:id])
    store.delet
    flash[:success] = "Store was successfully deleted."
    redirect_to stores_path
  end

  private
  
  def store_params
    params.require(:store).permit(:name)
  end
end
