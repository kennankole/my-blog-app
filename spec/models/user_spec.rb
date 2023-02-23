require "rails_helper"

RSpec.describe User, type: :model do

  describe 'associations' do
    it { should have_many(:likes).class_name('Like') }
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:comments).class_name('Comment') }
  end

  describe '#recent_posts' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    let!(:post1) { Post.create!(user: user, created_at: 1.day.ago , title: 'Post1', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post2) { Post.create!(user: user, created_at: 2.days.ago, title: 'Post2', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post3) { Post.create!(user: user, created_at: 3.days.ago, title: 'Post3', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post4) { Post.create!(user: user, created_at: 4.days.ago, title: 'Post4', text: 'Hello world', comment_counter: 0, likes_counter: 0) }

    it 'returns the three most recent posts' do
      recent_posts = user.recent_posts
      expect(recent_posts.count).to eq 3
      expect(recent_posts).to include(post1, post2, post3)
      expect(recent_posts).not_to include(post4)
    end
  end

  describe '#recent_comments' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    let!(:post1) { Post.create!(user: user, created_at: 1.day.ago , title: 'Post1', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post2) { Post.create!(user: user, created_at: 2.days.ago, title: 'Post2', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post3) { Post.create!(user: user, created_at: 3.days.ago, title: 'Post3', text: 'Hello world', comment_counter: 0, likes_counter: 0) }
    let!(:post4) { Post.create!(user: user, created_at: 4.days.ago, title: 'Post4', text: 'Hello world', comment_counter: 0, likes_counter: 0) }

    let!(:comment1) { Comment.create!(user: user, created_at: 1.day.ago , post: post1, text: 'Hello world') }
    let!(:comment2) { Comment.create!(user: user, created_at: 2.days.ago, post: post2, text: 'Hello world') }
    let!(:comment3) { Comment.create!(user: user, created_at: 3.days.ago, post: post3, text: 'Hello world') }
    let!(:comment4) { Comment.create!(user: user, created_at: 4.days.ago, post: post4, text: 'Hello world') }
    let!(:comment5) { Comment.create!(user: user, created_at: 5.days.ago, post: post3, text: 'Hello world') }
    let!(:comment6) { Comment.create!(user: user, created_at: 6.days.ago, post: post4, text: 'Hello world') }

    it 'returns the three most recent posts' do
      recent_comments = user.recent_comments
      expect(recent_comments.count).to eq 5
      expect(recent_comments).to include(comment1, comment2, comment3, comment4, comment5)
      expect(recent_comments).not_to include(comment6)
    end

    it 'updates post_counter attribute with the count of comments' do
      post_count = user.posts.count
      user.update_post_counter
      expect(user.post_counter).to eq post_count
    end
  end
end

