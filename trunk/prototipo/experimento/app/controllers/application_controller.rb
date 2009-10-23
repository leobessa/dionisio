# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  #filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user
     
  before_filter :verify_completed_stage, :if => :user_signed_in?
  
  private 
  def verify_completed_stage      
    current_user.advance_stage if current_user.completed_stage?
  end
  
end
