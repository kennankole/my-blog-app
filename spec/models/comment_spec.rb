require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe 'associations' do
    it { should belong_to(:post).class_name('Post') }
    it { should belong_to(:author).class_name('User') }
  end

  describe '#update_comment_counter' do
    let!(:user) { User.create!(name: 'ankole', photo: 'url/https', post_counter: 0) }
    let!(:post) do
      Post.create(title: 'Jambo', text: 'Vipi kaka', comment_counter: 0, likes_counter: 0, created_at: 10.day.ago,
                  author: user)
    end
    let!(:comment) { Comment.create(post:, author: user, text: 'Hi Tom!') }

    it 'increments the comment counter' do
      post.update(comment_counter: 0)
      post.comment_counter
      expect { comment.update_comment_counter }.to change { post.reload.comment_counter }.from(0).to(1)
    end
  end
end
