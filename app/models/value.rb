class Value < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :val_01,:val_02,:val_03,:val_04,:val_05,:val_06,:val_07,:val_08,:val_09,:val_10,:val_11,:val_12, :val_13,:val_14,:val_15,:val_16,:val_17,:val_18, :val_19,:val_20,:val_21,:val_22

end
