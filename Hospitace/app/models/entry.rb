class Entry < ActiveRecord::Base
  belongs_to :entry_template
  belongs_to :form
end
