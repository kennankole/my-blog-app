class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comment_counter, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments
  has_many :likes
  belongs_to :user
  # retrieve all users who have like a post
  has_many :likers, through: :likes, source: :user
  # retrieve all users who have commented on a post
  has_many :commenters, through: :comments, source: :user

  def update_comment_counter
    update(comment_counter: comments.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end
end
