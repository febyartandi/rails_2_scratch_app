class Member::DashboardController < ApplicationController

  layout 'member'
  
  before_filter :login_required
  
  def index
  
  end
  
end
