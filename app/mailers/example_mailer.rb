class ExampleMailer < ActionMailer::Base
  default from: "donotreply@kenanddanadesign.com"

  def sample_email(user,variants,count, blank_metal_product, mailer_metal, updated_metals, product_mailer)
    @user = user
    @mailer_variants = variants
    @updated_metals = updated_metals    
    @blank_metal_product = blank_metal_product
    @count = count
    @mailer_metal = mailer_metal
    @product_mailer = product_mailer
  	byebug
    mail(to: @user.email, subject: 'Shopify store varient update Email')
  end
end
