class Admin::CategoriesController < Admin::BaseController
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Successfully created a new category"
      redirect_to admin_categories_path
    else
      flash[:errors] = @category.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name,
                                     :description)
  end
end