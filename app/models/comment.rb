class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :post, foreign_key: 'post_id', class_name: 'Post'
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'

  after_save :update_comment_counter

  def update_comment_counter
    post.increment!(:comment_counter)
  end
end
