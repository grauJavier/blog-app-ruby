require 'rails_helper'
require 'factory_bot_rails'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { create(:user) }
  let!(:recent_posts) { create_list(:post, 3, author: user) }

  before do
    visit user_path(user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_selector("img[src='#{user.photo}']")
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'I can see the user\'s bio' do
    expect(page).to have_content(user.bio)
  end

  scenario 'I can see the user\'s first 3 posts' do
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'I can see a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(user))
  end
end
