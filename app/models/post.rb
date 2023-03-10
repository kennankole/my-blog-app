class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comment_counter, allow_nil: true, presence: false,
                              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, allow_nil: true, presence: false,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'post_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'post_id', class_name: 'Like'
  belongs_to :author, class_name: 'User'
  
  has_many :likers, through: :likes, source: :user
  
  has_many :commenters, through: :comments, source: :user

  before_create :set_defaults

  def update_post_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def set_defaults
    self.comment_counter ||= 0
    self.likes_counter ||= 0
  end
end
