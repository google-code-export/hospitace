# To change this template, choose Tools | Templates
# and open the template in the editor.
class RankingInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  
  

  def input
    label_method, value_method = detect_collection_methods

    @builder.send("collection_radio_buttons",
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options, &collection_block_for_nested_boolean_style
    )
  end
  
  protected
  
  def collection
    @collection=%w[A B C D E F] 
  end

  # Force item wrapper to be a label when using nested boolean, to support
  # configuring classes through :item_wrapper_class, and to maintain
  # compatibility with :inline style and default :item_wrapper_tag.
  def apply_nested_boolean_collection_options!(options)
    options[:item_wrapper_tag] = :td
  end

  def build_nested_boolean_style_item_tag(collection_builder)
    collection_builder.radio_button
  end
  
  def item_wrapper_class
  end
  
end
