class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true
  validates :post_counter, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'

  has_many :liked_comments, through: :likes, source: :comment

  has_many :liked_posts, through: :posts, source: :post

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
