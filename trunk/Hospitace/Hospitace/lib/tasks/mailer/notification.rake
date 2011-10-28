namespace :mailer do
  task :notification => :environment do
    def parity week
      if week % 2 == 0 then
        :odd
      else  
        :even
      end
    end
  
    parallel_classes = ParallelClass.arel_table
    visits = Visit.arel_table
    subjects = Subject.arel_table
    users = User.arel_table
    real_week_topics = RealWeekTopic.arel_table
    
    notify = {}
    
    both = ParallelClassParity.find_by_value('both')
    even = ParallelClassParity.find_by_value('even')
    odd = ParallelClassParity.find_by_value('odd')
    
    14.times do |week|
      query = parallel_classes.join(visits).on(parallel_classes[:id].eq(visits[:parallel_class_id]))
      query = query.join(subjects).on(subjects[:id].eq(parallel_classes[:subject_id]))
      query = query.join(users).on(users[:id].eq(visits[:user_id]))
      where = subjects[:notification].eq(true).and(visits[:is_teaching].eq(true))
      sub_where = real_week_topics[:parallel_class_id].eq(parallel_classes[:id]).and(real_week_topics[:week].eq(week))
      not_exists = real_week_topics.project(Arel.sql('*')).where(sub_where).exists.not
      where = where.and(not_exists)
      query = query.where(where)
      query = query.project(Arel.sql('*'))
      
      puts query.to_sql
      
      rows = []
      result = ActiveRecord::Base.connection.execute(query.to_sql)
      result.each_hash { |row| rows << row }
      puts rows.inspect
      #usrs = User.find_by_sql query.to_sql
      #usrs.each do |clazz|
     #   if 
        #
        #if clazz.parallel_class_parity_id == both.id then
          # add
        #elsif clazz.parallel_class_parity_id == even.id then
        #  if parity(week) == :even then
            # add
         # end
        #elsif clazz.parallel_class_parity_id == odd.id then
         # if parity(week) == :odd then
            # add
          #end
        #end
      #end
       # usrs.each do |name|
      #    puts name.last_name
      #  end
    #  end
    end
  end
end