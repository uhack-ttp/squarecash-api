class Api::V1::CorsController < Api::BaseController
  skip_before_action :restrict_access!
  skip_after_action :add_cors_headers

  ACCESS_CONTROL_MAX_AGE = "Access-Control-Max-Age".freeze

  ACCESS_CONTROL_ALLOW_ORIGIN_VALUE = "*".freeze
  ACCESS_CONTROL_MAX_AGE_VALUE      = "86400".freeze

  def preflight
    headers[ACCESS_CONTROL_ALLOW_ORIGIN]      = ACCESS_CONTROL_ALLOW_ORIGIN_VALUE
    headers[ACCESS_CONTROL_ALLOW_CREDENTIALS] = ACCESS_CONTROL_ALLOW_CREDENTIALS_VALUE
    headers[ACCESS_CONTROL_ALLOW_METHODS]     = ACCESS_CONTROL_ALLOW_METHODS_VALUE
    headers[ACCESS_CONTROL_ALLOW_HEADERS]     = ACCESS_CONTROL_ALLOW_HEADERS_VALUE
    headers[ACCESS_CONTROL_MAX_AGE]           = ACCESS_CONTROL_MAX_AGE_VALUE
    render plain: ""
  end
end
