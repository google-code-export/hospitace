# encoding: utf-8

require 'lib/kosapi'

namespace :import do
  task :user => :environment do
    beginning = Time.now
    
    Event.create(
      :date   => DateTime.now,
      :text   => 'Zahájen import uživatelů z KOSu.',
      :entity => 'import')
    
    clen = UserRole.find_by_codename "clen"
    pracovnik = UserRole.find_by_codename "pracovnik"
    
    KOSapi::User.all.each do |user|
      u = User.find_by_username user.username
      puts "Processing user with username: #{user.username}"
      if u.nil? then
          u = User.create(
          :first_name   => user.firstname,
          :last_name    => user.lastname,
          :username     => user.username,
          :last_login   => Time.now
          )

        if user.student? or user.teacher? then
          u.roles << clen
        end

        if user.teacher? then
          u.roles << pracovnik
        end

        if user.username.include? "id-" or user.firstname.nil? or user.lastname.nil? then
          u.is_externist = true
        end
        
        u.save!
      else
        puts "Updating an user with username: #{user.username}"
        if u.first_name != user.firstname then
          u.first_name = user.firstname
          u.save!
        end

        if u.last_name != user.firstname then
          u.last_name = user.lastname
          u.save!
        end

        if not u.is_externist and (u.first_name.nil? or u.last_name.nil? or u.username.include? "id-") then
          u.is_externist = true
          u.save!
        end
      end
    end
    
    final = Time.now - beginning
    Event.create(
      :date   => DateTime.now,
      :text   => "Dokončen import uživatelů, celkem naimportováno #{KOSapi::User.all.size} uživatelů. " +
                 "Import trval #{final} vteřin.",
      :entity => 'import')
  end
end