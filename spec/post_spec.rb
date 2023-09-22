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

  context 'recent_comments' do
    it 'returns the most recent comments, limited to 5' do
      user = User.create(name: 'John')
      post = Post.create(author: user, title: 'My Post', text: 'Some text')

      newest_comment = post.comments.create(user:, text: 'This is the newest comment', created_at: Time.now)
      middle_comment1 = post.comments.create(user:, text: 'This is a middle comment 1', created_at: 1.day.ago)
      middle_comment2 = post.comments.create(user:, text: 'This is a middle comment 2', created_at: 2.days.ago)
      middle_comment3 = post.comments.create(user:, text: 'This is a middle comment 3', created_at: 3.days.ago)
      older_comment = post.comments.create(user:, text: 'This is an older comment', created_at: 4.days.ago)

      post.comments.create(user:, text: 'This is an extra comment', created_at: 6.days.ago)

      recent_comments = post.recent_comments

      expect(recent_comments).to eq([newest_comment, middle_comment1, middle_comment2, middle_comment3, older_comment])
    end
  end

  context 'private methods' do
    it 'updates the author\'s posts_counter' do
      user = User.create(name: 'testuser')
      post = Post.new(author: user, title: 'My Post', text: 'Some text')
      post.save

      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end
end
