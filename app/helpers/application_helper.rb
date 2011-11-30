# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def page_title
    @page_title || "Your website" 
  end
   
  def flash_messages
    flash[:notice].blank? ? flash[:error] : flash[:notice]
  end
  
end
