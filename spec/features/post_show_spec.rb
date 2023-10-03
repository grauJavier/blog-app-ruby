require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let!(:user) { User.create(name: 'Juan') }
  let!(:post) { user.posts.create(title: 'Sample Post', text: 'This is a sample post') }
  let!(:comment1) { post.comments.create(user: user, text: 'This is the first comment') }
  let!(:comment2) { post.comments.create(user: user, text: 'This is the second comment') }

  scenario 'Visiting the post show page' do
    visit user_post_path(user, post)

    expect(page).to have_content(post.title)

    expect(page).to have_content(user.name)

    expect(page).to have_content("This is the second comment")

    expect(page).to have_content('0 Likes')

    expect(page).to have_content(post.text)

    expect(page).to have_content('2 Comments')

    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)

    click_link 'Back to all posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end
