class UsersController < ApplicationController
 
  before_filter :redirect_to_dashboard_if_logged_in
 
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    begin
      logout_keeping_session!
      @user = User.new(params[:user])
      @profile = Profile.new(params[:profile])
      
      validation = @user.valid?
      validation = @profile.valid?
      
      if validation and @user.save 
        @profile.user_id = @user.id
        @profile.save
        redirect_back_or_default('/login')
        flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
        UserMailer.deliver_signup_notification(@user)
      else
        flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
        render :action => 'new'
      end
        
    #rescue
      #redirect_to "/"
    end
  end

  def activate
    begin
      logout_keeping_session!
      user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
      case
      when (!params[:activation_code].blank?) && user && !user.active?
        user.activate!
        flash[:notice] = "Signup complete! Please sign in to continue."
        redirect_to '/login'
      when params[:activation_code].blank?
        flash[:error] = "The activation code was missing.  Please follow the URL from your email."
        redirect_back_or_default('/login')
      else 
        flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
        redirect_back_or_default('/login')
      end
      
    rescue
      redirect_to "/"
    end
  end
  
  def forgot_password
  end
  
  def setup_reset_code
    begin
      email = params[:email]
    
      if user = User.find_by_email(email)
        user.generate_reset_code
        UserMailer.deliver_reset_code(user)
        flash[:notice] = "We have send email instructions to your email, plese check it to continue "
        redirect_to login_path
      else
        flash.now[:error] = "Email is doesnt exist in our database"
        render :action => 'forgot_password'
      end
    
    #rescue
      #redirect_to "/"
    end
  end
  
  def reset_password
    begin
      code = params[:reset_code]
    
      if user = User.find_by_reset_code(code)
        rv, password = user.reset_password
        if rv 
          UserMailer.deliver_reset_password(user, password)
          flash[:notice] = "Your new password has been sent to your email"
          redirect_to login_path
        else
          flash.now[:error] = "Sorry, something wrong"
          redirect_to login_path
        end
      else
        flash.now[:error] = "Sorry, your reset code is invalid"
        redirect_to login_path
      end
    
    rescue
      redirect_to "/"
    end
  end
  
end
