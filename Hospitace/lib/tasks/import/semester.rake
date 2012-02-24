# encoding: utf-8

require 'kosapi'

namespace :import do
  task :semester => :environment do
    beginning = Time.now
        
    KOSapi::Semester.all.each do |semester|
      s = Semester.find_by_code semester.code
      puts "Processing semester with code: #{semester.code}"
      if s.nil? then
        s = Semester.create(
          :code         => semester.code,
          :name         => semester.name,
          :start   => semester.start,
          :end     => semester.end)
      else
        puts "Updating a semester with code: #{semester.code}"
        if s.name != semester.name then
          s.name = semester.name
          s.save!
        end
        
        if s.start != semester.start then
          s.start = semester.start
          s.save!
        end
        
        if s.end != semester.end then
          s.end = semester.end
          s.save!
        end
      end
    end
    
    final = Time.now - beginning
  end
end