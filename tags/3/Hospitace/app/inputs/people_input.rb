class PeopleInput < SimpleForm::Inputs::StringInput
      def input
        @builder.hidden_field("#{attribute_name}_id", input_html_options.merge(people_options(object.send(attribute_name)))) +
          @builder.text_field("#{attribute_name}_name", input_html_options.merge(people_name_options(object.send(attribute_name))))
      end

      def people_options(value = nil)
        {:value => value.nil?? nil : value.id}
      end
      
      def people_name_options(value = nil)
        {:value => value.nil?? nil : value.name,:disabled=>true}
      end

end
