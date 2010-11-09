module Messy
  class Posten
    def self.send(letter)
      data = {:address => letter.address}

      letter.files.each do |filename, contents|
        filename = File.basename(filename)
        data["files[#{filename}]"] = [contents].pack("m")
      end

      Messy.send_api_request('send_letter', data, :post)
    end
  end
end
