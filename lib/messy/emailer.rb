require "net/http"
require "uri"

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

      url = URI.parse(Messy.api_url + '/send_email')
      req = Net::HTTP::Post.new(url.path)
      req.basic_auth 'admin', 'admin'

      p data

      req.set_form_data(data)

      res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }

      p res.body
    end
  end
end