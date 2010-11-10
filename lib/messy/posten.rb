module Messy
  class Posten
    def self.send(letter)
      data = {:address => letter.address}

      letter.attachments.each do |filename, contents|
        filename = File.basename(filename)
        data["attachments[#{filename}]"] = [contents].pack("m")
      end

      Messy.send_api_request('send_letter', data, :post)
    end
  end
end
