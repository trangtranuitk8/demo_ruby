class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_cart


    protected
	def authorize
		unless User.find_by(id: session[:user_id])
			redirect_to login_url, notice: "Please log in"
		end
	end

	private
# Lay user dang dang nhap
	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def current_cart
		@current_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]

	end
	
end
