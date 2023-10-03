require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let!(:users) { create_list(:user, 5) }

  before do
    @test_user = create(:user, name: 'Juancho Mandinga', photo: 'https://i.pravatar.cc/150?img=69')
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

  scenario 'When I click on a user, redirected to that user show page.' do
    visit users_path
    click_link 'Juancho Mandinga'
    expect(page).to have_current_path(user_path(@test_user))
  end
end
