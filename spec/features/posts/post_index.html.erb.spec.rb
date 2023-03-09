require 'rails_helper'

RSpec.feature 'Posts index page' do
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
      Comment.create(author: user2, post: posts[0], text: 'Hello Alex this is nice'),
      Comment.create(author: user2, post: posts[0], text: 'Hi '),
      Comment.create(author: user2, post: posts[0], text: 'Awesome'),
      Comment.create(author: user2, post: posts[0], text: 'Fantastic'),
      Comment.create(author: user2, post: posts[0], text: 'Great'),
      Comment.create(author: user2, post: posts[0], text: 'Cheers'),
      Comment.create(author: user2, post: posts[0], text: 'Congrats!')
    ]
  end
  before :each do
    visit user_posts_path(user)
  end

  scenario 'Should see post title' do
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario 'Should see post body' do
    expect(page).to have_content(posts.first.text)
  end

  scenario 'Should see comment count' do
    expect(page).to have_content("Comments: #{posts.first.comment_counter},")
  end

  scenario 'Should see likes count' do
    expect(page).to have_content("Likes:#{posts.first.likes_counter}")
  end

  scenario 'Should see user profile info' do
    if user.photo
      expect(page).to have_css("img[src*='https://source.unsplash.com/user/c_v_r/1900x800']")
    else
      expect(page).to have_content(user.photo)
    end
    expect(page).to have_content("Username: #{user.name}")
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario 'Should see the first five comments' do
    visit user_posts_path(user2)
    comments.each do
      expect(posts.first.recent_comments.count).to eq(5)
    end
  end 

  scenario 'Shoudld direct to the post show page' do
    expect(page).to have_link(posts.first.text, href: user_post_path(posts.first.author, posts.first))
  end
end