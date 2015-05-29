class ApplicationMailer < ActionMailer::Base
  default from: "dont-reply@ebiddable.com"
  layout 'mailer'
end
