class People < ActiveRecord::Base 
  has_one :user
  has_many :peoples_relateds
  
  validates :username, :uniqueness => true
  
  def full_name
      "#{title_pre} #{firstname} #{lastname} #{title_post}"
  end
  
  def self.search(search)  
    if search  
      query,data = [],[]
      
      search.each do |key,value|  
        next if key == "teacher" and value == 0.to_s
        next if value == "" or value == 0 
        
        if key == "name"
          query << "concat(firstname, ' ' , lastname) LIKE ?"
          data << "%#{value}%"
        else
          query <<  " #{key} LIKE ?"
          data << "%#{value}%"
        end
      end 
      where(query.join(' AND'),*data)
    else  
      scoped  
    end
  end 
end