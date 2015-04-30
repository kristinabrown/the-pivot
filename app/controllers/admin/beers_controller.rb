class Admin::BeersController < Admin::BaseController

  def new
    @beer = Beer.new
  end

  def index
    @beers = Beer.all
  end

  def create
    @beer = Beer.new(beer_params)
    categories = params[:beer][:categories].reject(&:empty?) # Can someone please explain to me why this works?
    if @beer.save
      categories.each { |category| @beer.categories << Category.find(category) }
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
  end

  def update
    @beer = Beer.find(params[:id])
    categories = params[:beer][:categories].reject(&:empty?)
    if @beer.update(beer_params)
      redirect_to admin_beer_path(@beer)
      categories.each { |category| @beer.categories << Category.find(category) }
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
                                 :attachment,
                                 :category_id)
  end

end