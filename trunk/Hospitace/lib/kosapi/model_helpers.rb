# To change this template, choose Tools | Templates
# and open the template in the editor.

module KOSapi
  module ModelHelpers  
    
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:extend, ClassMethods)
    end
    
    module ClassMethods
      def self.extended(base)
        def self.extended(base)
          base.class_eval do
            def self.attrs_translate(*args)    
              args.each do |attribute|
                define_method "#{attribute}_t" do
                  value = self.send(attribute)
                  value = value.first if value.is_a?(Array)
                  scope = self.class.name.demodulize.downcase
                  KOSapi::I18n.t value, :scope=>".#{scope}.#{attribute}", :default=>value
                end    
              end
            end
          end
        end 
      end
    end
    module InstanceMethods
    end
  end
end

  