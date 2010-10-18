module Messy
  class Emailer
    def self.send(email)
      data = {
        :subject    => email.subject,
        :body       => email.body,
        :recipients => email.recipients,
        :from       => email.from
      }

      if email.attachments.length > 0
        email.attachments.each do |file|
          filename = File.basename(file)
          contents = File.read(file)

          data["attachments[#{filename}]"] = [contents].pack("m")
        end
      end

      if email.headers.length > 0
        email.headers.each { |name, value| data["headers[#{name}]"] = value }
      end

      Messy.send_api_request('send_email', data)
    end
  end
end