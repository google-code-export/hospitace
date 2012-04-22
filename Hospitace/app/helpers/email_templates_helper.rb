module EmailTemplatesHelper
   
  module Tagged
   
    module ModelHelpers
      def self.included(base)
        base.instance_eval do
          extend  ClassMethods
          include InstanceMethods
        end
      end
    
      module ClassMethods    
        @tagged = []
        def attrs_tagged(*args)
          @tagged = args
        end
      
        def tagged
          return @tagged
        end
      end
      module InstanceMethods
      end
    end
      
    module EmailBuilder
      def self.included(base)
        base.instance_eval do
          extend  ClassMethods
        end
      end
    
      module ClassMethods 
        @@tagged = []
      
        def get_tagged
          @@tagged
        end
      
        def tagged=(name)
          @@tagged.push(name)
        end
      
        def source(model,relation,*args)
          @@path = args
          @@relation = relation
          model.tagged.each do |attribute|
            @@attribute = attribute
            self.tagged=("#{relation}_#{attribute}")
            class << self
              attribute = @@attribute
              relation = @@relation
              path = @@path
              define_method "#{relation}_#{attribute}" do |parametr|
                object = get_relation_by_path(parametr,*path)
                return get_string_value(object,attribute) unless object.is_a? Array
                return object.collect { |item| 
                  get_string_value(item,attribute)  
                }.join(", ")
              end
            end
          end
        end
      
        def source_spec(relation,name,*args)
          @@path = args
          @@relation = relation
          @@name = name
          self.tagged=("#{relation}_#{name}")
          class << self
            name = @@name
            relation = @@relation
            path = @@path
            define_method "#{relation}_#{name}" do |parametr|
              object = get_relation_by_path(parametr,*path)
              yield(object)
            end
          end
        end
      
        def source_datetime(model,relation,*args)
        end
      
        def get_relation_by_path(object,*args)
          res = object
          args.each do |path|
            return nil if res.nil?
            if res.is_a? Hash
              res = res[path]
            else
              res = res.send(path)
            end
          end
          res
        end
         
        def get_string_value(object,attribute)
          return "" if object.nil?
          res = object.send(attribute) 
          return "" if res.nil?
          return ::I18n.l(res,:format=>:long) if(res.is_a?(Time) || res.is_a?(DateTime) || res.is_a?(Date))
          return res = res.to_lable if !res.is_a? String
          res
        end
      end
    end
  end
  
  
end

class EmailBuilder
  include EmailTemplatesHelper::Tagged::EmailBuilder

  @@path = ""
  
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
  source People, :observers, :evaluation, :observation, :peoples
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