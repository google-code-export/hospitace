# To change this template, choose Tools | Templates
# and open the template in the editor.

module KOSapi
  
  require File.dirname(__FILE__) + '/i18n/translator'
  
  module I18n
    @@scope = "kosapi"
    @@translator = nil
    
    class << self
      # Returns the current scope. Defaults to :authlogic
      def scope
        @@scope
      end
   
      # Sets the current scope. Used to set a custom scope.
      def scope=(scope)
        @@scope = scope
      end
      
      # Returns the current translator. Defaults to +Translator+.
      def translator
        @@translator ||= Translator.new
      end
      
      # Sets the current translator. Used to set a custom translator.
      def translator=(translator)
        @@translator = translator
      end
    
      # All message translation is passed to this method. The first argument is the key for the message. The second is options, see the rails I18n library for a list of options used.
      def translate(key, options = {})
        translator.translate key, { :scope => I18n.scope }.merge(options){|key, oldval, newval| 
          if key == :scope
            oldval + newval 
          else
            newval
          end
        }
      end
      alias :t :translate
    end
    
  end
end
