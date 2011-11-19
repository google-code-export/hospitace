# encoding: utf-8

require 'lib/kosapi'

namespace :import do
  task :semester => :environment do
    beginning = Time.now
    
    Event.create(
      :date   => DateTime.now,
      :text   => 'Zahájen import semestrů z KOSu.',
      :entity => 'import')
    
    KOSapi::Semester.all.each do |semester|
      s = Semester.find_by_code semester.code
      puts "Processing semester with code: #{semester.code}"
      if s.nil? then
        s = Semester.create(
          :code         => semester.code,
          :name         => semester.name,
          :start_date   => semester.start,
          :end_date     => semester.end)
      else
        puts "Updating a semester with code: #{semester.code}"
        if s.name != semester.name then
          s.name = semester.name
          s.save!
        end
        
        if s.start_date != semester.start then
          s.start_date = semester.start
          s.save!
        end
        
        if s.end_date != semester.end then
          s.end_date = semester.end
          s.save!
        end
      end
    end
    
    final = Time.now - beginning
    Event.create(
      :date   => DateTime.now,
      :text   => "Dokončen import semestrů, celkem naimportováno #{KOSapi::Semester.all.size} semestrů. " +
                 "Import trval #{final} vteřin.",
      :entity => 'import')
  end
end