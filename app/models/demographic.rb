class Demographic < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :age, :state, :topic_01, :topic_02, :topic_03, :site_01

end
