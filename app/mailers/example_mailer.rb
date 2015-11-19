class ExampleMailer < ActionMailer::Base
  default from: "from@example.com"

  def sample_email(user,variants,count, blank_metal_product, mailer_metal)
    @user = user
    @mailer_variants = variants
    @blank_metal_product = blank_metal_product
    @count = count
    @mailer_metal = mailer_metal
    mail(to: @user.email, subject: 'Shopify store varient update Email')
  end
end
