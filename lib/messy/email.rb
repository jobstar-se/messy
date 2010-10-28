module Messy
  class Email
    attr_accessor :subject, :body, :recipients, :from, :send_me_copy

    def attachments
      @attachments ||= {}
    end

    def headers
      @headers ||= {}
    end
  end
end
