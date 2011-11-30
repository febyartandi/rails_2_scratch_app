class Profile < ActiveRecord::Base
  include Authentication
  
  belongs_to :user
  belongs_to :profile
  
  validates_presence_of :first_name
  
  validates_format_of       :first_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :first_name,     :maximum => 100
  validates_length_of       :last_name,     :maximum => 100
end  
  

