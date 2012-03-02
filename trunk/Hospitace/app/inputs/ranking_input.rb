# To change this template, choose Tools | Templates
# and open the template in the editor.

class RankingInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input  
    
    label_method, value_method = detect_collection_methods

    @builder.collection_radio_buttons(
      attribute_name, %w[A B C D E], value_method, label_method,
      input_options, input_html_options
    )

  end
end
