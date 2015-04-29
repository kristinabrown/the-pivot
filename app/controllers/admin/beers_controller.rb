class Admin::BeersController < Admin::BaseController

  def new
  #  @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @beer = Beer.new
  end

  def index
    @beers = Beer.all
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
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
    @beer.update(beer_params)
    redirect_to admin_beer_path(@beer)
  end

  private

  def beer_params
    params.require(:beer).permit(:name,
                                 :description,
                                 :price,
                                 :state,
                                 :attachment)
  end

end