
class People < KOSapi::User
  include KOSapi
  
  def self.find(id)
    self.find_by_id(id)
  end
  
  def self.search(search)  
    
    if search  
      puts search[:is_teacher]
      data = all
      find = data.select do |x|         
        ((!search[:username].empty?) ? x.username =~ /(?i)#{search[:username]}/ : true)  && 
        ((!search[:name].empty?) ?  x.full_name =~ /(?i)#{search[:name]}/ : true ) && 
        ((!search[:email].empty?) ? x.email =~ /(?i)#{search[:email]}/ : true ) && 
        ((search[:teacher] != 0.to_s) ? x.teacher? : true)
      end
    else  
      all  
    end  
  end 
end
