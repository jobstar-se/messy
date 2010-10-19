require "net/http"
require "uri"

module Messy
  class APIException < StandardError; end

  extend self

  autoload :Emailer, 'messy/emailer'
  autoload :Email,   'messy/email'

  def api_url=(url)
    @api_url = url
  end

  def api_url
    @api_url or raise "API URL is not specified"
  end

  def api_token=(token)
    @api_token = token
  end

  def api_token
    @api_token or raise "API token is not specified"
  end

  def send_api_request(api_method, params, request_method = :get)
    if request_method == :post
      url = URI.parse(Messy.api_url + "/#{api_method}.json")
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(params)
    else
      url = URI.parse(Messy.api_url + "/#{api_method}.json?#{hash_to_url_params(params)}")
      req = Net::HTTP::Get.new(url.path)
    end

    # TODO
    req.basic_auth 'admin', 'admin'

    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      return ::ActiveSupport::JSON.decode(res.body)
    else
      raise Messy::APIException, res.error!
    end
  end

  private

    def hash_to_url_params(hash)
      elements = []
      hash.keys.size.times do |i|
        elements << "#{hash.keys[i]}=#{hash.values[i]}"
      end
      elements.join('&')
    end
end
