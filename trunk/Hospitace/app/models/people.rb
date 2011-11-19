
class People < KOSapi::User
  include KOSapi
  
  def self.search(search)  
    if search  
      data = all
      find = data.select do |x|
        x.username =~ /#{search}/ ||x.id =~ /#{search}/ || x.full_name =~ /#{search}/ 
      end
    else  
      all  
    end  
  end 
end
