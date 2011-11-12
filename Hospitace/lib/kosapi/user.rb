
module KOSapi
  class User < Resource
    RESOURCE = "#{API_URI}people/"
    
    attr_reader :id, :email, :firstname, :lastname, :title_pre, :title_post,:username

    @@all = nil

    def self.all
      return @@all if not @@all.nil?
      pure_data = get("#{RESOURCE}?#{PARAM}")
      return Array[] if pure_data.nil?
      data_users = pure_data['person']
      return Array[] if data_users.nil?
      if data_users.kind_of? Hash then
        @@all ||= Array[self.new data_users]
      else
        @@all ||= data_users.collect {|user| self.new user}
      end
    end
    
    def self.find_by_username username
      data_user = get("#{RESOURCE}#{username}?#{PARAM}")
      self.new(data_user)
    end
    
    def self.find_by_id id
      data_user = get("#{RESOURCE}id-#{id}?#{PARAM}")
      self.new(data_user)
    end

    def initialize(user)
      return unless valid? user
      
      @id = user['@id']
      @email = user['email']
      @firstname = user['firstName']
      @lastname = user['surname']
      @username = user['login']
      @title_pre = user['titlePre']
      @title_post = user['titlePost']
      @student = user['student']
      @teacher = user['teacher']
      @uri = user['uri']
    end
    
    def username
      @username.nil? ? "id-#{id}" : @username
    end
    
    def student?
      if @student.nil? then
        false
      else
        true
      end
    end
    
    def teacher?
      if @teacher.nil? then
        false
      else
        true
      end
    end
    
    def full_name
      "#{@title_pre} #{@firstname} #{@lastname} #{@title_post}"
    end
  end 
end