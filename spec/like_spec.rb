require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'associations' do
    it 'belongs to a user' do
      association = Like.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      association = Like.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  context 'update_likes_counter' do
    it 'updates the likes_counter for the associated post' do
      user = User.create(name: 'Bob')
      post = Post.create(title: 'Another Post', author: user)
      like = Like.create(user: user, post: post)

      expect(post.likes_counter).to eq(0)

      like.save

      post.reload
      expect(post.likes_counter).to eq(1)
    end
  end
end
