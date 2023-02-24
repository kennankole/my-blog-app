require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:photo) }
    it { should validate_numericality_of(:post_counter).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:likes).with_foreign_key('author_id') }
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
  end

  describe '#recent_posts' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    let!(:post1) do
      Post.create(title: 'Post1', text: 'Hello world 1', comment_counter: 0, likes_counter: 0, created_at: 1.day.ago,
                  author: user)
    end
    let!(:post2) do
      Post.create(title: 'Post2', text: 'Hello world 2', comment_counter: 0, likes_counter: 0, created_at: 2.days.ago,
                  author: user)
    end
    let!(:post3) do
      Post.create(title: 'Post3', text: 'Hello world 3', comment_counter: 0, likes_counter: 0, created_at: Time.current,
                  author: user)
    end

    it 'returns the three most recent posts' do
      expect(user.recent_posts).to eq([post3, post1, post2])
    end
  end
end
