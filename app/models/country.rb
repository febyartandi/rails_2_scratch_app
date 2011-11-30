class Country < ActiveRecord::Base
  
  has_many :profiles
  #validates_presence_of :name, :iso_code
  
end
