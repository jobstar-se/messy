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

  def send_api_request(method, params)
    url = URI.parse(Messy.api_url + '/' + method)
    req = Net::HTTP::Post.new(url.path)

    # TODO
    req.basic_auth 'admin', 'admin'
    req.set_form_data(params)

    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      return res.body
    else
      raise Messy::APIException, res.error!
    end
  end
end
