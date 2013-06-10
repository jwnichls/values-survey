class ArticleContentRating < ActiveRecord::Base
  belongs_to :article_rating
  validates_presence_of :tag_01,:tag_02,:tag_03,:rating_01,:rating_02

end
