# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a complete input.
  # You can remove any component from the wrapper, change the order or even
  # add your own to the stack. The options given to the wrappers method
  # are used to wrap the whole input.
  config.wrappers :inline, :class => 'control-group', :error_class => :error do |b|
    b.use :placeholder
    b.use :label, :class => 'control-label'
    b.use :tag => 'div', :class => 'controls' do |ba|
      ba.use :input
      ba.use :error, :tag => :span, :class => :'help-inline'
      ba.use :hint, :tag => :p, :class => :'help-block'
    end
  end

  config.wrappers :stacked, :class => "control-group", :error_class => :error do |b|
    b.use :placeholder
    b.use :label, :class => 'control-label'
    b.use :hint, :tag => :p, :class => :'help-block'
    b.use :tag => 'div', :class => 'controls' do |input|
      input.use :input
      input.use :error, :tag => :span, :class => :'help-inline'
    end
  end

  config.wrappers :prepend, :class => "control-group", :error_class => :error do |b|
    b.use :placeholder
    b.use :label, :class => 'control-label'
    b.use :hint, :tag => :p, :class => :'help-block'
    b.use :tag => 'div', :class => 'controls' do |input|
      input.use :tag => 'div', :class => 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :error, :tag => :span, :class => :'help-inline'
    end
  end

  config.wrappers :append, :class => "control-group", :error_class => :error do |b|
    b.use :placeholder
    b.use :label, :class => 'control-label'
    b.use :hint, :tag => :p, :class => :'help-block'
    b.use :tag => 'div', :class => 'controls' do |input|
      input.use :tag => 'div', :class => 'input-append' do |append|
        append.use :input
      end
      input.use :error, :tag => :span, :class => :'help-inline'
    end
  end
  
 config.wrappers :label_wrapped, :class => "control-group", :error_class => :error do |b|
    b.use :placeholder
    b.use :label, :class => 'control-label'
    b.use :tag => 'div', :class => 'controls' do |div|
      div.use :tag => 'label', :class => 'checkbox' do |item|
        item.use :input
        item.use :error, :tag => :span, :class => :'help-inline'
        
      end
    end
  end

  # Method used to tidy up errors.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :span

  # CSS class to add for error notification helper.
  config.error_notification_class = :error_notification

  # ID to add for error notification helper.
  # config.error_notification_id = nil

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag, defaulting to span.
  # config.item_wrapper_tag = :span

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required| "#{required} #{label}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the class to use on all forms. Default is simple_form.
  config.form_class = "form-horizontal"

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use default HTML5 validations (novalidate option).
  # Default is enabled.
  config.browser_validations = true

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # Default size for text inputs.
  # config.default_input_size = 50

  # When false, do not use translations for labels.
  config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache simple form inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for buttons
  config.button_class = 'btn'
end
