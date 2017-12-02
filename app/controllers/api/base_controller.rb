class Api::BaseController < ApplicationController
  before_action :restrict_access!
  after_action  :add_cors_headers
  skip_before_action :verify_authenticity_token

  ORIGIN_HEADER_KEY   = "HTTP_ORIGIN".freeze
  ORIGIN_X_HEADER_KEY = "HTTP_X_ORIGIN".freeze

  ACCESS_CONTROL_ALLOW_ORIGIN      = "Access-Control-Allow-Origin".freeze
  ACCESS_CONTROL_ALLOW_CREDENTIALS = "Access-Control-Allow-Credentials".freeze
  ACCESS_CONTROL_ALLOW_METHODS     = "Access-Control-Allow-Methods".freeze
  ACCESS_CONTROL_ALLOW_HEADERS     = "Access-Control-Allow-Headers".freeze

  ACCESS_CONTROL_ALLOW_CREDENTIALS_VALUE = "true".freeze
  ACCESS_CONTROL_ALLOW_METHODS_VALUE     = "POST, GET, PUT, DELETE, OPTIONS".freeze
  ACCESS_CONTROL_ALLOW_HEADERS_VALUE     = "X-Requested-With, Token, Content-Type, " \
                                           "Authorization, Accept, If-None-Match, " \
                                           "If-Modified-Since, X-User-Agent".freeze

  private

  def api_key
    @api_key ||= authenticate_with_http_token do |token, _|
      ApiKey.where(token: token).where("expires_at > ?", Time.current).first
    end
  end

  def restrict_access!
    request_http_token_authentication if api_key.blank?
  end

  def add_cors_headers
    headers[ACCESS_CONTROL_ALLOW_ORIGIN]      = access_control_allow_origin_domain
    headers[ACCESS_CONTROL_ALLOW_CREDENTIALS] = ACCESS_CONTROL_ALLOW_CREDENTIALS_VALUE
    headers[ACCESS_CONTROL_ALLOW_METHODS]     = ACCESS_CONTROL_ALLOW_METHODS_VALUE
    headers[ACCESS_CONTROL_ALLOW_HEADERS]     = ACCESS_CONTROL_ALLOW_HEADERS_VALUE
  end

  def access_control_allow_origin_domain
    api_key.domains.split(/\r?\n/).detect { |d| d == origin_header } || "null"
  end

  def origin_header
    @origin_header ||= request.env[ORIGIN_HEADER_KEY] || request.env[ORIGIN_X_HEADER_KEY]
  end
end
