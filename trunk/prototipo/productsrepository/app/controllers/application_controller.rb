# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :activate_authlogic

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password , :password_confirmation

    helper_method :current_user
    
    def title
      h(@title_full ? @title_full : [@title_prefix, "SITE_TITLE"].compact.join(' – '))
    end

    private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_login
      unless current_user
        flash[:notice] = t(:must_be_logged_in)
        session[:restricted_url_to_access] = request.url
        redirect_to login_path
      end
    end
end
