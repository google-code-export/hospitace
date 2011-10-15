# encoding: utf-8

require 'lib/kosapi'

namespace :import do
  task :room => :environment do
    beginning = Time.now
    
    Event.create(
      :date   => DateTime.now,
      :text   => 'Zahájen import místnostní z KOSu.',
      :entity => 'import')
      
    z4 = Building.find_by_code "Z4:"
    t2 = Building.find_by_code "T2:"
    z2 = Building.find_by_code "Z2:"
    kng = Building.find_by_code "KN:G"
    kna = Building.find_by_code "KN:A"
    kne = Building.find_by_code "KN:E"
    unknown = Building.find_by_code "X"
    
    KOSapi::Room.all.each do |room|
      r = Room.find_by_code room.code
      puts "Processing room with code: #{room.code}"
      if r.nil? then
        building =  if room.code.include? z4.code then
                      z4
                    elsif room.code.include? t2.code then
                      t2
                    elsif room.code.include? z2.code then
                      z2
                    elsif room.code.include? kng.code then
                      kng
                    elsif room.code.include? kna.code then
                      kna
                    elsif room.code.include? kne.code then
                      kne
                    else 
                      unknown
                    end
                  
        r = Room.create(
          :code         => room.code,
          :building     => building)
      else
        # not expecting to move room to another building so no checking is neccesery
      end
    end
    
    final = Time.now - beginning
    Event.create(
      :date   => DateTime.now,
      :text   => "Dokončen import místností, celkem naimportováno #{KOSapi::Room.all.size} místností. " +
                 "Import trval #{final} vteřin.",
      :entity => 'import')
  end
end