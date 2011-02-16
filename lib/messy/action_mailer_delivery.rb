module Messy
  class ActionMailerDelivery

    def initialize(values = {}) 
      # (optional)
    end 

    def deliver!(mail)
      email = Messy::Email.new
      email.subject    = mail.subject 
      email.body       = mail.body
      email.recipients = [ mail.to ].join(',')
      email.from       = mail.from
      email.check_spam = false
      email.attachments = mail.attachments.map{ |a| [ a.filename, a.body.to_s ] }
      Messy::Emailer.send(email)
    end 
  end 
end 

