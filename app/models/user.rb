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
end
