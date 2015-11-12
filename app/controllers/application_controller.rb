class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  	
  	shop_url = "https://6acdc0a7e033747ed3ed49f53ee6139d:bbc52658c951c9e75bb4f5b03b819492@surprisepost.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    
end
