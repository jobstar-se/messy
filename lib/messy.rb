#require "messy/emailer"

module Messy
  extend self
  autoload :Emailer, 'messy/emailer'

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
end
