class Admin::BeersController < Admin::BaseController

  def new
    @beer = Beer.new
    @categories = Category.all
  end

  def index
    @beers = Beer.all
  end

  def create
    @beer = Beer.new(beer_params)
    categories = params[:beer][:category_ids].to_a.reject(&:empty?)
    if @beer.save
      categories.each { |category_id| @beer.categories << Category.find(category_id) }
      flash[:notice] = "Beer successfully created!"
      redirect_to admin_beer_path(@beer)
    else
      flash[:errors] = @beer.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy
    redirect_to admin_beers_path
  end

  def edit
    @beer = Beer.find(params[:id])
    @categories = Category.all
  end

  def update
    @beer = Beer.find(params[:id])
    categories = params[:beer][:category_ids].reject(&:empty?)
    if @beer.update(beer_params)
      @beer.categories.destroy_all
      categories.each { |category| @beer.categories << Category.find(category) }
      redirect_to admin_beer_path(@beer)
    else
      render :edit
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name,
                                 :description,
                                 :price,
                                 :state,
                                 :attachment )
  end

end