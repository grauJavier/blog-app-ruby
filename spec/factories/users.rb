FactoryBot.define do
  factory :user do
    name { 'Test User' }
    bio { 'Test Bio' }
    posts_counter { 0 }
  end
end