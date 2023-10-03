require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let!(:users) { create_list(:user, 5) }

  before do
    visit users_path
  end

  scenario 'I can see the username of all other users' do
    users.each do |user|
      expect(page).to have_text(user.name)
    end
  end

  scenario 'I can see the profile picture for each user' do
    users.each do |user|
      expect(page).to have_selector("img[src='#{user.photo}']")
    end
  end

  scenario 'I can see the number of posts each user has written' do
    users.each do |user|
      expect(page).to have_text("Number of posts: #{user.posts_counter}")
    end
  end
end
