class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://#{AppConfig.site_url}/users/activate?activation_code=#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{AppConfig.site_url}"
  end
  
  def reset_code(user)
    setup_email(user)
    @subject    += 'Request to Reset your password at #{AppConfig.application_name}'
    @body[:url]  = "http://#{AppConfig.site_url}/users/reset_password?reset_code=#{user.reset_code}"
  end
  
  def reset_password(user, password)
    setup_email(user)
    @subject    += 'Request to Reset your password at #{AppConfig.application_name}'
    @body[:password]  = password
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = AppConfig.email_from
      @subject     = "#{AppConfig.application_name} - "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
