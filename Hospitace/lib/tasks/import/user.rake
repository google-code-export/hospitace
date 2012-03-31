
require 'kosapi'

namespace :import do
  task :user => :environment do
    beginning = Time.now
    
    added = 0
    updated = 0
    
    count = KOSapi::User.all.size
    value = 0
    KOSapi::User.all.each do |user|
      value+=1 
      u = People.find_by_id(user.id) #|| People.find(user.id)
      #puts "#{user.username} #{value}/#{count}"
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
        added += 1 if u.save!
      else
        if u.username != user.username then
          u.username = user.username
          u.save!
        end
        
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
        updated+=1
      end
    end
    
    puts "Created users #{added}"
    puts "Updated users #{updated}"
    puts "Total users #{KOSapi::User.all.size}"
    
    final = Time.now - beginning
  end
end