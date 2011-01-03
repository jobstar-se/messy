module Messy
  class ActionMailerDelivery

    def initialize(values = {}) 
      # (optional)
    end 

    def deliver!(mail)
      email = Messy::Email.new
      email.subject    = mail.subject 
      email.body       = mail.body
      email.recipients = mail.to
      email.from       = mail.from
      email.check_spam = false
      Messy::Emailer.send(email)
    end 
  end 
end 

