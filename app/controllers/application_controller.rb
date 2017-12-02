class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  protect_from_forgery unless: -> { request.format.json? }

  private

  def do_not_set_cookie
    request.session_options[:skip] = true
  end
end
