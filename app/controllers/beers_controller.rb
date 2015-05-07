class BeersController < ApplicationController

  def index
    @categories = Category.all
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end
end
