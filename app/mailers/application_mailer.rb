class ApplicationMailer < ActionMailer::Base
  default from: "app@mail.com"
  layout "mailer"
end