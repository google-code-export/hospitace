# encoding: utf-8

require 'kosapi'

namespace :import do
  task :room => :environment do
    beginning = Time.now
   
    added_rooms = 0;
    updated_rooms = 0;
    
    KOSapi::Room.all.each do |room|
      r = Room.find_by_code room.code
      #puts "Processing room with code: #{room.code}"
      if r.nil? then            
        r = Room.create(
          :code => room.code
        )
        added_rooms+=1
      else
        updated_rooms+=1
      end
    end
    
    puts "Created rooms #{added_rooms}"
    puts "Updated rooms #{updated_rooms}"
    puts "Total rooms #{KOSapi::Room.all.size}"
    
    final = Time.now - beginning
  end
end