require "rails_helper"

RSpec.feature "users#index" do
  before :each do
    @user1 = User.create!(name: 'Alice', bio: 'Maths teacher', photo: "https://source.unsplash.com/user/c_v_r/1900x800", post_counter: 0)
    @user2 = User.create!(name: 'Bob', bio: 'Computer science lecturer', photo: "https://source.unsplash.com/user/c_v_r/100x100", post_counter: 0) 

    user1 = Post.create!(author: @user1, title: 'Hello there', text: 'This is my first post')
    user2 = Post.create!(author: @user2, title: 'Hello there', text: 'This is my first Blog post')
    user3 = Post.create!(author: @user1, title: 'Hello mate', text: 'This is my second blog post')
    user4 = Post.create!(author: @user2, title: 'Hello there mate', text: 'This is my second blog post')

    visit users_path
  end

  it 'should display all users' do
    expect(page).to have_content("Username: #{@user1.name}")
    expect(page).to have_content("Username: #{@user2.name}")
  end

  it 'should see user profile picture' do
    if @user1.photo
      expect(page).to have_css("img[src*='https://source.unsplash.com/user/c_v_r/1900x800']")
    else
      expect(page).to have_content(user.photo)
    end
  end

  it 'should show links to view post for a single user' do
    expect(page).to have_link(@user1.name, href: user_path(id: @user1.id))
    expect(page).to have_link(@user2.name, href: user_path(id: @user2.id))
  end

  it 'should see all the post counter of users' do
    expect(page).to have_content('2')
  end

  it 'should redirect to the users#show page' do
    click_link 'Alice'
    expect(page).to have_current_path user_path(@user1.id)
  end
end
