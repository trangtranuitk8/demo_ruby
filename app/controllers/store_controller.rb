class StoreController < ApplicationController
	skip_before_action :authorize
	include CurrentCart
	before_action :set_cart

  def index
  	@products = Product.paginate(page: params[:page], per_page: 8).order("created_at DESC")
  	@categories = Category.all
  end
end
