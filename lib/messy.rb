require "net/http"
require "uri"

module Messy
  class APIException < StandardError; end
  class InvalidData  < APIException;  end

  extend self

  autoload :Emailer, 'messy/emailer'
  autoload :Email,   'messy/email'
  autoload :Posten,  'messy/posten'
  autoload :Letter,  'messy/letter'
  autoload :ActionMailerDelivery, 'messy/action_mailer_delivery'

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
      req_url = Messy.api_url + "/#{api_method}.json?#{hash_to_url_params(params)}"

      url = URI.parse(req_url)
      req = Net::HTTP::Get.new(req_url)
    end

    # TODO: replace with tokens
    req.basic_auth 'admin', 'admin'

    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      begin
        return ::ActiveSupport::JSON.decode(res.body)
      rescue => e
        raise [e, res.body].inspect
      end
    when Net::HTTPClientError
      raise Messy::InvalidData, res.body if res.code == "422" # unprocessable entity
    end

    raise Messy::APIException, res.error!
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
  
ActionMailer::Base.add_delivery_method :messy, Messy::ActionMailerDelivery
