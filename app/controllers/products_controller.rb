class ProductsController < ApplicationController
  skip_before_action :authorize, only: [:show, :index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  include CurrentCart
  before_action :set_cart
  # GET /products
  # GET /products.json
  def index
    
    if params[:search]
      @products = Product.paginate(page: params[:page], per_page: 8).search(params[:search]).order("created_at DESC")
    else
      @products = Product.paginate(page: params[:page], per_page: 8).order("created_at DESC")
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @products = Product.search_product(params[:id]).take(3)
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
    # @product.categories.build
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    p product_params
    p @product, '*******************'

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    # redirect_to products_path, notice:  "product has been deleted."
    
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :upload_image, categories: [])
    end



end
