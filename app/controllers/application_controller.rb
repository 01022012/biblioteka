class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authorize
  before_filter :set_locale
  
  protected 
  
  def pjax_layout
    'pjax'
  end
  
  def available_locales
    %w( en fi )
  end
  
  # Sets i18n flash message
  def set_flash_message(status, opts = {})
    message = I18n.t("flash.#{controller_name}.#{action_name}.#{status.to_s}")
    if message.present?
      opts[:now] ? flash.now[status] = message : flash[status] = message
    end
  end
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to new_session_path if current_user.nil?
  end
  
  def set_locale
    I18n.locale = request.compatible_language_from(available_locales) || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
end
