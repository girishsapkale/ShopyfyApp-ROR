class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #before_action :check_shop_url

  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  if Shop.first.nil?
    Shop.create(:url => "https://5000b6fab6a48677813d80080e505c18:1eebe1b232ede28bfa0e68c673a317d7@rormobikasa.myshopify.com/admin")
  else
    shop_url = Shop.last.url
    ShopifyAPI::Base.site = shop_url
  end
  

  
end