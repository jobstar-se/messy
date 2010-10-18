module Messy
  class Email
    attr_accessor :subject, :body, :recipients, :from, :headers

    def attachments
      @attachments ||= []
    end
  end
end
