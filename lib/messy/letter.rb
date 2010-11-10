module Messy
  class Letter
    attr_accessor :address

    def attachments
      @attachments ||= {}
    end
  end
end
