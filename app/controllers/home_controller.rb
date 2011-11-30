class HomeController < ApplicationController
  before_filter :redirect_to_dashboard_if_logged_in, :only => :index
  
  def index
  end
  
end
