require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'column validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:comment_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:author).class_name('User') }
  end

  describe '#update_comment_counter' do
    let!(:user) { User.create!(name: 'ankole', photo: 'url/https', post_counter: 0) }
    let!(:post) do
      Post.create(title: 'Jambo', text: 'Vipi kaka', comment_counter: 0, likes_counter: 0, created_at: 10.day.ago,
                  author: user)
    end

    it 'increments the comment counter' do
      expect { post.update_post_counter }.to change { user.reload.post_counter }.from(0).to(1)
    end
  end

  describe '#recent_comments' do
    let!(:user) { User.create!(name: 'ankole', photo: 'url/https', post_counter: 0) }
    let!(:post) do
      Post.create(title: 'Jambo', text: 'Vipi kaka', comment_counter: 0, likes_counter: 0, created_at: 10.day.ago,
                  author: user)
    end

    let!(:comment1) { post.comments.create(text: 'Comment 1', post:, author: user) }
    let!(:comment2) { post.comments.create(text: 'Comment 2', post:, author: user) }
    let!(:comment3) { post.comments.create(text: 'Comment 3', post:, author: user) }
    let!(:comment4) { post.comments.create(text: 'Comment 4', post:, author: user) }
    let!(:comment5) { post.comments.create(text: 'Comment 5', post:, author: user) }
    let!(:comment6) { post.comments.create(text: 'Comment 6', post:, author: user) }

    it 'returns the 5 most recent comments' do
      expect(post.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
