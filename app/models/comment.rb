class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :post, class_name: 'Post'
  belongs_to :author, class_name: 'User'

  def update_comment_counter
    post.increment!(:comment_counter)
  end
end
