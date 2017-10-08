class ApplicationController < ActionController::Base
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500
  before_action :check_trailing_slash
  
  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
  
  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  def hello
    render html: "hello, world!"
  end

  private
    def check_trailing_slash
      end_with_slash = request.original_fullpath.split('?').at(0).end_with?("/")
      if action_name == 'index' then
        raise ActionController::RoutingError.new("The URL of the index action must end with a slash.") unless end_with_slash && request.get?
      else
        raise ActionController::RoutingError.new("The URL of the non-index action MUST NOT end with a slash.") if end_with_slash && request.get?
      end
    end

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end