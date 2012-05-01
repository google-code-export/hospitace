# To change this template, choose Tools | Templates
# and open the template in the editor.
module EmailTemplates
  module Tagged

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