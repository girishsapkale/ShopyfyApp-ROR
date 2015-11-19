class ExampleMailer < ActionMailer::Base
  default from: "from@example.com"

  def sample_email(user,variants,count)
    @user = user
    @mailer_variants = variants
    @count = count
    mail(to: @user.email, subject: 'Shopify store varient update Email')
  end
end
