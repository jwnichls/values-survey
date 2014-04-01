class Demographic < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :age, :state, :site_01, :topic_01, :topic_02, :topic_03, :topic_04, :topic_05, :topic_06

end
