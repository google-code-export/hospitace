class Entry < ActiveRecord::Base
  belongs_to :entry
  belongs_to :form
end
