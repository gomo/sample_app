class ApplicationController < ActionController::Base
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500
  
  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
  
  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :check_trailing_slash!

  def hello
    render html: "hello, world!"
  end

  private
    def check_trailing_slash!
      uri = request.env["REQUEST_URI"]
      raise ActionController::RoutingError.new("The all path must not end with a slash.") if uri && uri != "/" && uri.end_with?("/")
    end
end