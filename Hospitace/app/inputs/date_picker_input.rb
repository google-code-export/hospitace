class DatePickerInput < SimpleForm::Inputs::Base
      def input
        @builder.text_field(attribute_name, input_html_options.merge(datepicker_options(object)))
      end

      def datepicker_options(object)
        value = object.send(attribute_name) unless object.nil?
        datepicker_options = {:value => value.nil?? nil : I18n.localize(value),:ref=>"datepicker"}
      end

end
