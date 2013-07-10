class Participant < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :personalities
  has_one :demographics
  has_many :article_ratings
#  has_many :article_content_ratings
  has_one :values

  validates_presence_of :condition

end
