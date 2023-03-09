require 'rails_helper'

RSpec.feature "User show page" do

  let!(:user) { User.create!(name: 'Alice', bio: 'Maths teacher', photo: "https://source.unsplash.com/user/c_v_r/1900x800", post_counter: 0) }
  let!(:posts) do
    [
      Post.create(author: user, title: 'Hello there mate1', text: 'This is my first blog post'),
      Post.create(author: user, title: 'Hello there mate2', text: 'This is my second blog post'),
      Post.create(author: user, title: 'Hello there mate3', text: 'This is my third blog post'),
      Post.create(author: user, title: 'Hello there mate4', text: 'This is my fourth blog post'),
      Post.create(author: user, title: 'Hello there mate5', text: 'This is my fifth  blog post'),
    ]
  end 

  scenario 'User interaction on the profile' do
    visit user_path(user)
    expect(page).to have_css("img[src*='https://source.unsplash.com/user/c_v_r/1900x800']")
    expect(page).to have_content("Username: #{user.name}")
    expect(page).to have_content("Number of posts: #{user.posts.count}")
    expect(page).to have_content(user.bio)

    click_link 'Alice'
    expect(page).to have_current_path user_path(user.id)

    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(user)

    posts[0..2].each do |post|
      expect(user.recent_posts.count).to eq(3)
      expect(page).to have_link(post.text, href: user_post_path(post.author, post))
    end
  end
end