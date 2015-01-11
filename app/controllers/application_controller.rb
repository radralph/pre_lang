class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  #->Prelang (user_login:devise)
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in)        { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end


  private
  
  #-> Prelang (user_login:devise)
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
    end
  end

  def getToken
    #placeholders
    code = ""
    app_id = ""
    app_secret = ""
    response = Net::HTTP.post_form(URI.parse('http://developer.globelabs.com.ph/oauth/access_token'),
        {'app_id'=>app_id, 'app_secret'=> app_secret, 'code' => code})
    puts response.code
    puts response.message
    puts response.body
    access_token = JSON.parse(response.body)['access_token']
    msisdn = JSON.parse(response.body)['subscriber_number']
    puts access_token
    puts msisdn
  end

  def sendSms
    uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/<shortcode>/requests")
    token = ""
    uri.query = "access_token=#{token}"
    message = "Test"
    msisdn = ""
    response = Net::HTTP.post_form(uri, {'address' => msisdn, 'message' => message})  
    puts response.code
    puts response.message
    puts response.body
  end

  def getDetails(params)
    logger.info params[:access_token]
    logger.info params[:subscriber_number]
  end

end
