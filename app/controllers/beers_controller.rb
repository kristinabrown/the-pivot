class BeersController < ApplicationController

  def index
    @beers = Beer.all #lose this
    @categories = Category.all 
  end

  def show
    @beer = Beer.find(params[:id])
  end
end