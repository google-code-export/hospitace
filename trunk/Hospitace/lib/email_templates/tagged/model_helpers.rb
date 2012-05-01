# To change this template, choose Tools | Templates
# and open the template in the editor.
module EmailTemplates
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
  end
end
