class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #before_action :check_shop_url

  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 	# rescue_from 'both URI are relative' do |exception|
  #  	redirect_to redirect_to set_shop_homes_path
 	# end
 	rescue_from URI::BadURIError, :with => :shop_not_found

 	def shop_not_found
 		redirect_to set_shop_homes_path
 	end
end