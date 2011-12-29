
module KOSapi
  class Room < Resource
    RESOURCE = "#{API_URI}rooms/"
    
    attr_reader :id, :code
    
    @@all = nil
    
    def self.all
      return @@all if not @@all.nil?
      pure_data = get("#{RESOURCE}?#{PARAM}")
      return Array[] if pure_data.nil?
      data_rooms = pure_data['room']
      return Array[] if data_rooms.nil?
      if data_rooms.kind_of? Hash then
        @@all ||= Array[self.new data_rooms]
      else
        @@all ||= data_rooms.collect {|room| self.new room}
      end
    end
    
    def self.find_by_code code
      data_room = get("#{RESOURCE}#{code}/?#{PARAM}")
      self.new(data_room)
    end

    def initialize(room)
      return unless valid? room
      
      @id = room['@id']
      @code = room['code']
    end
  end
end