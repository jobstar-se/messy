module Messy
  class Letter
    attr_accessor :address, :from_email

    def files
      @files ||= {}
    end
  end
end
