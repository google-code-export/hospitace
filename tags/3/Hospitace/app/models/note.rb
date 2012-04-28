class Note < ActiveRecord::Base
  belongs_to :observation
  belongs_to :people
end
