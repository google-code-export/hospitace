# To change this template, choose Tools | Templates
# and open the template in the editor.

module EmailTemplates
  class EmailBuilder
    include Tagged::EmailBuilder

    @@path = AppConfig.email_base_url
  
    def self.path
      @@path
    end
  
    def self.path=(path)
      @@path=path
    end
  
    source Parallel, :parallel, :evaluation, :observation, :parallel
    source People, :guarant, :evaluation, :guarant
    source People, :teacher, :evaluation, :teacher
    source People, :administrator, :evaluation, :administrator
    source People, :observers, :evaluation, :observation, :observers_people
    source People, :head_of_department, :evaluation, :head_of_department
    source Course, :course, :evaluation, :observation, :course
    source Form, :form, :form
    source Semester, :semester, :evaluation, :observation, :semester
    
    source_spec :form,:url, :form do |form|
      "#{self.path}/evaluations/#{form.evaluation.id}/forms/#{form.id}"
    end
    source_spec :evaluation,:url, :evaluation do |evaluation|
      "#{self.path}/evaluations/#{evaluation.id}"
    end
    source_spec :observation,:url, :evaluation, :observation do |observation|
      "#{self.path}/observations/#{observation.id}"
    end
    
    source_spec :parallel,:start, :evaluation, :observation, :parallel do |parallel|
      I18n.l(parallel.start,:format=>"%H:%M")
    end
    source_spec :parallel,:finish, :evaluation, :observation, :parallel do |parallel|
      I18n.l(parallel.finish,:format=>"%H:%M")
    end
     
    def self.build (template,objects = {})
      text = template.text
      get_tagged.each do |tag|
        text = text.gsub(/%#{tag}%/,self.send(tag,objects) || "" )
      end
      return text  
    end
  end
end
