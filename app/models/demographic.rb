class Demographic < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :age, :state

end
