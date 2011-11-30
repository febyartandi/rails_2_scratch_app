class Member::UsersController < ApplicationController
  layout 'member'
  before_filter :login_required
  
  def edit
    @user = current_user
    @profile = @user.profile
  end
  
  def update
    profile = current_user.profile
    respond_to do |format|
      if profile and profile.update_attributes(params[:profile])
        flash[:notice] = "Your changes has been saved"
        format.html { redirect_to "/member/dashboard" }
      else
        flash.now[:error] = "Your changes cant saved, please check your input"
        format.html { render :action => :edit }
      end
    end
    
  end
  
  def update_password
    user = current_user
    respond_to do |format|
      if user and user.update_attributes(params[:user])
        flash[:notice] = "Your passowrd has been changed"
        format.html { redirect_to "/member/dashboard" }
      else
        flash.now[:error] = "Your changes cant saved, please check your input"
        format.html { render :action => :edit }
      end
    end
    
  end
  
end
