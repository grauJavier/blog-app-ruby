require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it 'requires a non-blank title' do
      post = Post.new(title: '', comments_counter: 2, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'requires title not to exceed 250 characters' do
      long_title = 'A' * 251
      post = Post.new(title: long_title, comments_counter: 3, likes_counter: 2)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'requires comments_counter to be greater than or equal to zero' do
      post = Post.new(title: 'My Post', comments_counter: -1, likes_counter: 2)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'requires likes_counter to be greater than or equal to zero' do
      post = Post.new(title: 'My Post', comments_counter: 3, likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end

    it 'allows valid posts' do
      user = User.create(name: 'testuser')
      post = Post.new(author: user, title: 'My Post', text: 'Some text')
      expect(post).to be_valid
    end
  end
end
