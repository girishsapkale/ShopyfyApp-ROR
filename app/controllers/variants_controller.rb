class VariantsController < ApplicationController
  
  def update_variants_value
    if request.put?      
      params_variant = params[:query_1].downcase
      params_new_price = params[:query_2]
      if( !params[:query_1].empty? || !params[:query_2].empty?)
        @total_products = ShopifyAPI::Product.count
        @total_pages = (@total_products / 250.0).ceil
        products = []
        @total_pages.times do |x|
          page = x+1
          products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
        end
        count = 0
        @mailer_variant = []
        @metal_blank_product = []
        @mailer_metal = []
        products.each do |product|        
          product.variants.each do |variant|
           if variant.option2 == params_variant

            db_price_value = Variant.where(:metal_title => variant.option1).first.metal_price
            if db_price_value.blank?
              @metal_blank_product << product
              @mailer_variant << variant
              @mailer_metal << variant.option1
            end
              new_price = params_new_price.to_i + db_price_value.to_i
              variant.price = new_price.to_s
              variant.save
              count = count + 1 
            end
          end
        end
      end
      
      flash[:notice] = " #{count} Variants price was successfully updated."

      # Sends email to user when user is created.
      ExampleMailer.sample_email(User.first, @mailer_variant, count, @metal_blank_product, @mailer_metal).deliver

    else
      #display only form
    end
  end


end