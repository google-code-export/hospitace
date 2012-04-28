class DatetimePickerInput < SimpleForm::Inputs::Base
      def input
        @builder.text_field(:date, input_html_options.merge(datepicker_options(object.send(:date)))) + " " +
          @builder.text_field(:time, input_html_options.merge(timepicker_options(object.send(:time))))
      end

      def datepicker_options(value = nil)
        puts value.inspect
        value = Time.parse(value).to_date if value.is_a? String
        datepicker_options = {:value => value.nil?? nil : I18n.localize(value),:ref=>"datepicker"}
      end
      
      def timepicker_options(value = nil)
        puts value.inspect
        value = Time.parse(value).to_time if value.is_a? String
        datepicker_options = {:value => value.nil?? nil :  I18n.localize(value.in_time_zone(Time.zone),:format=>"%H:%M")}
      end
      

end
