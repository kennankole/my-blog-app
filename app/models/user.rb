class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, presence: true
  validates :email, presence: true
  validates :photo, presence: false
  validates :post_counter, presence: false


  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'

  has_many :liked_comments, through: :likes, source: :comment

  has_many :liked_posts, through: :posts, source: :post

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def password_match?
    errors[:password] << 'must be provided' if password.blank?
    errors[:password] << 'and confirmation do not match' if password != password_confirmation
    password == password_confirmation and !password.blank?
  end
end
