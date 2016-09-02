class Variant < ActiveRecord::Base
  validates :metal_title, uniqueness: true

  def self.update_variants_value(params,usr_email)
  	ShopifyAPI::Base.site = Shop.last.url

  	#@emailid = 'neha@mobikasa.com'
    @emailid = 'aniltimt@gmail.com'
    #@total_products = ShopifyAPI::Product.count
    #@total_pages = (@total_products / 250.0).ceil
    #products = []
    #@total_pages.times do |x|
    #  page = x+1
    #  products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
    #end
    #products = Product.includes(:metals).where(:prod_id => product.id).first
    @count = 0
    @mailer_variant = []
    @blank_metal_product = []
    @mailer_metal = []
    @updated_metals = []
    @product_mailer = []
    
    #db_products = Product.where("status = ? and flag = ?", 'all_filled', false)
    db_products = Product.where("status = ?", 'all_filled')

    params[:prices].each_with_index do |price, ind|
      if price.present?
        params_price = price
        params_diamond = params[:gemstones][ind]

        gemst = Gemstone.find_by_name(params_diamond)
        gemst.price = params_price
        gemst.save!        

        db_products.each do |dbproduct|
          shopify_product = ShopifyAPI::Product.find(dbproduct.prod_id)        
          shopify_product.variants.each_with_index do |shopify_variant, index|

            if shopify_variant.option2 == params_diamond
              
              db_product = dbproduct#Product.includes(:metals).where(:prod_id => product.id).first
              if db_product #&& db_product.status == "all_filled"
                metal = db_product.metals.where(:name => shopify_variant.option1).first
              else
              	metal = ''	
              	db_price_value = 0
              end              

              metal_product_id = 0
              if metal.present?
                if metal.price == 0
                  db_price_value = 0
                else
                  db_price_value = metal.price
                end                
                metal_product_id = metal.product_id              
              end
              if db_price_value == 0
                @blank_metal_product << shopify_product.title
                @mailer_variant << shopify_variant
                @mailer_metal << shopify_variant.option1
              end
              if db_price_value != 0
              	old_price = shopify_variant.price
                new_price = params_price.to_f + db_price_value.to_f
                shopify_variant.price = new_price.to_s              
                shopify_variant.save
                VariantBackup.create(:title => shopify_variant.title, :sku => shopify_variant.sku, :product_id => metal_product_id,
                  :store_variant_id => shopify_variant.id, :store_product_id => shopify_variant.product_id,
                  :position => shopify_variant.position, :initial_price => old_price.to_i, :status => 'delay_updated',
                  :current_price => shopify_variant.price.to_i, :updated_prices => "#{old_price},#{shopify_variant.price}")

                @updated_metals << shopify_variant
                @product_mailer << shopify_product.title
                @count = @count + 1
                dbproduct.flag = true
                dbproduct.save! 
              end             

            end
          end          
        end
      end
    end
    ExampleMailer.delay.sample_email(@emailid, @mailer_variant, @count, @blank_metal_product, @mailer_metal, @updated_metals, @product_mailer)
    end
end
