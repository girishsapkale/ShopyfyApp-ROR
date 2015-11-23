class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #before_action :check_shop_url

  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
end