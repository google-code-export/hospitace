# To change this template, choose Tools | Templates
# and open the template in the editor.


class Room < ActiveRecord::Base 
  validates :code, :uniqueness => true
end

#require 'kosapi'
#
#class Room < KOSapi::Room
#  include KOSapi 
#end
