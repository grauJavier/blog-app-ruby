require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let!(:user) { User.create(name: 'Juan', posts_counter: 2) }
  let!(:post1) { user.posts.create(title: 'Post 1', text: 'This is the first post') }
  let!(:post2) { user.posts.create(title: 'Post 2', text: 'This is the second post') }

  scenario 'Visiting the user post index page' do
    visit user_posts_path(user)

    expect(page).to have_css("img[src*='#{user.photo}'][alt='User Photo']")

    expect(page).to have_content(user.name)

    expect(page).to have_content("Number of posts: #{user.posts_counter}")

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)

    expect(page).to have_content(post1.comments.first.text) if post1.comments.any?

    expect(page).to have_content(post2.comments.first.text) if post2.comments.any?

    expect(page).to have_content("#{post1.comments.count} Comments | #{post1.likes.count} Likes")
    expect(page).to have_content("#{post2.comments.count} Comments | #{post2.likes.count} Likes")

    expect(page).to have_css('.pagination')

    click_link post1.title
    expect(current_path).to eq(user_post_path(user_id: user.id, id: post1.id))
  end
end
