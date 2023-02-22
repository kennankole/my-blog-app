class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :comment_counter, presence: false
  validates :likes_counter, presence: false

  has_many :comments
  has_many :likes
  belongs_to :user
  # retrieve all users who have like a post
  has_many :likers, through: :likes, source: :user
  # retrieve all users who have commented on a post
  has_many :commenters, through: :comments, source: :user
end
