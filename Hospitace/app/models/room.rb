class Room < ActiveRecord::Base 
  validates :code, :uniqueness => true
end