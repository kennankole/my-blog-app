require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validataion' do
    it { should belong_to(:post).class_name('Post') }
    it { should belong_to(:author).class_name('User') }
  end

  describe '#update_likes_counter' do
    let!(:user) { User.create!(name: 'ankoo', photo: 'url/https', post_counter: 0) }
    let!(:post) do
      Post.create(author: user, title: 'Greetings', text: 'Hello mater', comment_counter: 0, likes_counter: 0,
                  created_at: 8.day.ago)
    end
    let!(:like) { Like.create(author: user, post:) }

    it 'increments the likes_counter of the associated post by 1' do
      expect { like.update_likes_counter }.to change { post.reload.likes_counter }.from(0).to(1)
    end
  end
end
