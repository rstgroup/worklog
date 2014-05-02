class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_action

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end
  
  def check_action
    logger.info { params[:controller] + " " + params[:action] }    
  end

end
