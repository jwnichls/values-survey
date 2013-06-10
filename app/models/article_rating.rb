class ArticleRating < ActiveRecord::Base
  belongs_to :participant
  has_one :article_content_rating
  validates_presence_of :rating_01
  
end
