require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'assigns all users to @users' do
      get '/users'
      expect(assigns(:users)).to eq(User.all)
    end

    it 'it returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in response body' do
      get '/users'
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #show' do
    let!(:user) { User.create!(name: 'Anko', photo: 'url/https', post_counter: 0) }
    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'returns the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in response body' do
      get "/users/#{user.id}"
      expect(response.body).to include("User's page")
    end
  end
end
