# To change this template, choose Tools | Templates
# and open the template in the editor.


class Course < KOSapi::Course
  
    def self.search(search)  
      if search  
        data = all
        find = data.select do |x|
          x.code =~ /#{search}/ ||x.name =~ /#{search}/
        end
      else  
        all  
      end  
    end 
end
