class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comment_counter, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'
  # retrieve all users who have like a post
  has_many :likers, through: :likes, source: :user
  # retrieve all users who have commented on a post
  has_many :commenters, through: :comments, source: :user

  def update_post_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
