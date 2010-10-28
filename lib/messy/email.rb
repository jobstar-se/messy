module Messy
  class Email
    attr_accessor :subject, :body, :recipients, :from, :bcc_sender

    def attachments
      @attachments ||= {}
    end

    def headers
      @headers ||= {}
    end
  end
end
