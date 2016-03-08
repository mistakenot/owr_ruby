class Review < ActiveRecord::Base
  belongs_to :title
  validates :content, presence: true

  def getVoteCount
    Vote.where(review_id: id).count
  end
end
