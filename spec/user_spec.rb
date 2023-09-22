require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'requires a name' do
      user = User.new(posts_counter: 5)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires posts_counter to be greater than or equal to zero' do
      user = User.new(name: 'Juan', posts_counter: -1)
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end

    it 'allows valid users' do
      user = User.new(name: 'Alicia', posts_counter: 3)
      expect(user).to be_valid
    end
  end

  context 'recent_posts' do
    it 'returns the most recent posts, limited to 3' do
      user = User.create(name: 'John', posts_counter: 2)

      newest_post = user.posts.create(title: 'Newest Post', text: 'This is the newest post', created_at: Time.now)
      middle_post = user.posts.create(title: 'Middle Post', text: 'This is a middle post', created_at: 1.day.ago)
      older_post = user.posts.create(title: 'Old Post', text: 'This is an old post', created_at: 2.days.ago)

      user.posts.create(title: 'Extra Post', text: 'This is an extra post', created_at: 3.days.ago)

      recent_posts = user.recent_posts

      expect(recent_posts).to eq([newest_post, middle_post, older_post])
    end
  end
end
