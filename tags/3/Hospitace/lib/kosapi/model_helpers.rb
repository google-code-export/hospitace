# To change this template, choose Tools | Templates
# and open the template in the editor.

module KOSapi
  
  require File.dirname(__FILE__) + '/i18n/translator'
  
  module ModelHelpers  
    
    def self.included(base)
      base.instance_eval do
        extend  ClassMethods
        include InstanceMethods
      end
    end
    
    module ClassMethods
      def attrs_translate(*args)    
        args.each do |attribute|
          define_method "#{attribute}_t" do
            value = self.send(attribute)
            value = value.first if value.is_a?(Array)
            scope = self.class.name.demodulize.downcase
            KOSapi::I18n.t value, :scope=>".#{scope}.#{attribute}", :default=>value
          end    
        end
      end
      
      def attrs_tagged(*args)
        @@tagged = args
      end
      
      def tagged
        return @@taged || []
      end
    end
    module InstanceMethods
    end
  end
end

  