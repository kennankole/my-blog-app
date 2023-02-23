require "rails_helper"


RSpec.describe Post, type: :model do
  describe "validations" do
    let(:user) { User.create(name: "John Doe") }
    let(:valid_attributes) { { title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet", user: user, comment_counter: 0, likes_counter: 0 } }

    it "requires title" do
      post = Post.new(valid_attributes.merge(title: nil))
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "requires text" do
      post = Post.new(valid_attributes.merge(text: nil))
      expect(post).to_not be_valid
      expect(post.errors[:text]).to include("can't be blank")
    end

    it "requires a user" do
      post = Post.new(valid_attributes.merge(user: nil))
      expect(post).to_not be_valid
      expect(post.errors[:user]).to include("can't be blank")
    end

    it "requires comment_counter to be a non-negative integer" do
      post = Post.new(valid_attributes.merge(comment_counter: "foo"))
      expect(post).to_not be_valid
      expect(post.errors[:comment_counter]).to include("is not a number")
      
      post = Post.new(valid_attributes.merge(comment_counter: -1))
      expect(post).to_not be_valid
      expect(post.errors[:comment_counter]).to include("must be greater than or equal to 0")
    end

    it "requires likes_counter to be a non-negative integer" do
      post = Post.new(valid_attributes.merge(likes_counter: "bar"))
      expect(post).to_not be_valid
      expect(post.errors[:likes_counter]).to include("is not a number")
      
      post = Post.new(valid_attributes.merge(likes_counter: -1))
      expect(post).to_not be_valid
      expect(post.errors[:likes_counter]).to include("must be greater than or equal to 0")
    end
  end
end


