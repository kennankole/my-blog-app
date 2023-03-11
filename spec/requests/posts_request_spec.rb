require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    it 'it returns http success' do
      get user_posts_path(user, 1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    it 'it returns http success' do
      post = user.posts.create!(
        title: 'Jambo',
        text: 'Vipi kaka',
        comment_counter: 0,
        likes_counter: 0,
        created_at: 10.days.ago,
        author: user
      )
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'includes correct placeholder text in response body' do
      post = user.posts.create!(
        title: 'Jambo',
        text: 'Vipi kaka',
        comment_counter: 0,
        likes_counter: 0,
        created_at: 10.days.ago,
        author: user
      )
      get user_post_path(user, post)
      expect(response.body).to include('BlogApp')
    end
  end
end
