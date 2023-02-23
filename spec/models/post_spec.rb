require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) do
    described_class.new(
      title: 'Sample post', text: 'Hello poeple',
      comment_counter: 0, likes_counter: 0
    )
  end

  let(:user) { User.create(name: 'Anko', photo: 'url/https') }
  let(:comment) { Comment.create(text: 'Lorem ipsum', post:, user:) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:likes).class_name('Like') }
    it { should have_many(:comments).class_name('Comment') }
    it { should have_many(:likers).through(:likes).source(:user) }
    it { should have_many(:commenters).through(:comments).source(:user) }
  end

  describe 'validations' do
    it 'validates presence of title' do
      post.title = nil
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates maximum length of title' do
      post.title = 'y' * 251
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates presence of text' do
      post.text = nil
      expect(post).not_to be_valid
      expect(post.errors[:text]).to include("can't be blank")
    end

    it 'validates comment counter is an int >= 0' do
      post.comment_counter = 'text message'
      expect(post).not_to be_valid
      expect(post.errors[:comment_counter]).to include('is not a number')

      post.comment_counter = -1
      expect(post).not_to be_valid
      expect(post.errors[:comment_counter]).to include('must be greater than or equal to 0')

      post.comment_counter = 0
      user.posts << post
      expect(post).to be_valid
    end

    it 'validates likes counter is an integer which is >= 0' do
      should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0)
    end
  end

  it 'updates likes_counter attribute with the count of likes' do
    likes_count = post.likes.count
    post.update_likes_counter
    expect(post.likes_counter).to eq likes_count
  end

  it 'updates comment_counter attribute with the count of comments' do
    comment_count = post.comments.count
    post.update_comment_counter
    expect(post.comment_counter).to eq comment_count
  end
end
