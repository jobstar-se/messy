module Messy
  class Emailer
    def self.fetch_incoming_emails(since_id)
      Messy.send_api_request('get_incoming_emails', :since_id => since_id)
    end

    def self.fetch_outgoing_errors(since_id)
      Messy.send_api_request('get_outgoing_errors', :since_id => since_id)
    end

    def self.send(email)
      data = {
        :subject    => email.subject,
        :body       => email.body,
        :user_body  => email.user_body,
        :recipients => email.recipients,
        :from       => email.from,
        :bcc_sender => email.bcc_sender || false
      }

      if email.attachments.length > 0
        email.attachments.each do |filename, contents|
          filename = File.basename(filename)
          data["attachments[#{filename}]"] = [contents].pack("m")
        end
      end

      if email.headers.length > 0
        email.headers.each { |name, value| data["headers[#{name}]"] = value }
      end

      Messy.send_api_request('send_email', data, :post)
    end
  end
end