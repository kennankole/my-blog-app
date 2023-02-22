class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true
  validates :post_counter, presence: false

  has_many :comments
  has_many :likes
  has_many :posts
  # retrieve all the comments that the user has liked
  has_many :liked_comments, through: :likes, source: :comment
  # retrieve all the posts that the user has liked
  has_many :liked_posts, through: :posts, source: :post

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_post_counter
    update(post_counter: posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
