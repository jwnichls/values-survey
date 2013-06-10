class Personality < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :big5_01,:big5_02,:big5_03,:big5_04,:big5_05,:big5_06,:big5_07,:big5_08,:big5_09,:big5_10,:big5_11,:gender
end
