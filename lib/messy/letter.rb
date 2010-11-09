module Messy
  class Letter
    attr_accessor :address

    def files
      @files ||= {}
    end
  end
end
