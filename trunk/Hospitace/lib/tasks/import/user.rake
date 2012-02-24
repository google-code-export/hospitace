
require 'kosapi'

namespace :import do
  task :user => :environment do
    beginning = Time.now
    
    KOSapi::User.all.each do |user|
      u = People.find_by_username(user.username) #|| People.find(user.id)
      puts "Processing user with username: #{user.username}"
      if u.nil? then
          u = People.new(
          :email        => user.email,
          :firstname   => user.firstname,
          :lastname    => user.lastname,
          :title_pre    => user.title_pre,
          :title_post   => user.title_post,
          :student      => user.student?,
          :teacher      => user.teacher?,
          :username     => user.username
          )
        u.id = user.id
        u.save!
      else
        puts "Updating an user with username: #{user.username}"
        if u.firstname != user.firstname then
          u.firstname = user.firstname
          u.save!
        end

        if u.lastname != user.firstname then
          u.lastname = user.lastname
          u.save!
        end
        
        if u.email != user.email then
          u.email = user.email
          u.save!
        end
        
        if u.title_pre != user.title_pre then
          u.title_pre = user.title_pre
          u.save!
        end
        
        if u.title_post != user.title_post then
          u.title_post = user.title_post
          u.save!
        end
        
        if u.student != user.student? then
          u.student = user.student?
          u.save!
        end
        
        if u.teacher != user.teacher? then
          u.teacher = user.teacher?
          u.save!
        end
        
      end
    end
    
    final = Time.now - beginning
  end
end