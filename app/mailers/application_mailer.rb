class ApplicationMailer < ActionMailer::Base
  default from: "donotreply@every-doc.com"
  layout 'mailer'
end
