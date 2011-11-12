require 'kosapi'

class User < ActiveRecord::Base
  attr_reader :email, :firstname, :lastname, :title_pre, :title_post
  
  after_find :load_user
  
  validates :login, :uniqueness => true
  
  has_many :observations, :dependent => :destroy
 
  def load_user
    user = People.find_by_username(self.login)
    @email = user.email
    @firstname = user.firstname
    @lastname = user.lastname
    @title_pre = user.title_pre
    @title_post = user.title_post
  end
  
  def full_name
    "#{@title_pre} #{@firstname} #{@lastname} #{@title_post}"
  end
  
  def self.search(search)  
    if search  
      where('login LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end 
end
