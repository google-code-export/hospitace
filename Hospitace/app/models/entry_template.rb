class EntryTemplate < ActiveRecord::Base
  belongs_to :form_template
  has_many :entry
end
