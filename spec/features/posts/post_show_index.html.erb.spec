require 'rails_helper'

RSpec.feature 'Posts show page' do
  let!(:user) { User.create!(name: 'Alice', bio: 'Maths teacher', photo: "https://source.unsplash.com/user/c_v_r/1900x800", post_counter: 0) }
  let!(:user2) { User.create!(name: 'Bob', bio: 'Computer science lecturer', photo: "https://source.unsplash.com/user/c_v_r/100x100", post_counter: 0) }
  let!(:posts) do
    [
      Post.create(author: user, title: 'Hello there mate1', text: 'This is my first blog post'),
      Post.create(author: user, title: 'Hello there mate2', text: 'This is my second blog post'),
      Post.create(author: user, title: 'Hello there mate3', text: 'This is my third blog post'),
      Post.create(author: user, title: 'Hello there mate4', text: 'This is my fourth blog post'),
      Post.create(author: user, title: 'Hello there mate5', text: 'This is my fifth  blog post'),
    ]
  end
  let!(:comments) do
    [
      Comment.create(author: user2, post: posts.first, text: 'Hello Alex this is nice'),
      Comment.create(author: user2, post: posts.first, text: 'Hi '),
      Comment.create(author: user2, post: posts.first, text: 'Awesome'),
      Comment.create(author: user2, post: posts.first, text: 'Fantastic'),
      Comment.create(author: user2, post: posts.first, text: 'Great'),
      Comment.create(author: user2, post: posts.first, text: 'Cheers'),
      Comment.create(author: user2, post: posts.first, text: 'Congrats!')
    ]
  end
  
  before :each do
    visit user_post_path(posts.first.author, posts.first)
  end

  scenario 'When viewing a post' do
    expect(page).to have_content("Post##{posts.first.id} by #{posts.first.author.name}")
    expect(page).to have_content("Title: #{posts.first.title}")
    expect(page).to have_content("Comments: #{posts.first.comment_counter} Likes: #{posts.first.likes_counter}")
    expect(page).to have_content(posts.first.text)
  end

  scenario 'User can like a post' do
    expect(page).to have_content("Likes: 0")
    click_button 'Like'
    expect(page).to have_content("Likes: 1")
  end

  scenario 'Post Author can see the commentors name and comment left' do
    expect(page).to have_content("#{comments.author.name} : #{Post.first.text}")
  end
end
