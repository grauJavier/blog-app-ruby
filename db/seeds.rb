# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

numbers = (1..70).to_a.shuffle
User.create(name: 'Alice Johnson', photo: "https://i.pravatar.cc/150?img=#{numbers.pop}", bio: 'Passionate about photography and travel.')
User.create(name: 'Ethan Smith', photo: "https://i.pravatar.cc/150?img=#{numbers.pop}", bio: 'Software developer by day, aspiring musician by night.')
User.create(name: 'Olivia Davis', photo: "https://i.pravatar.cc/150?img=#{numbers.pop}", bio: 'Bookworm, tea lover, and art enthusiast.')
User.create(name: 'Liam Wilson', photo: "https://i.pravatar.cc/150?img=#{numbers.pop}", bio: 'Fitness enthusiast and certified personal trainer.')
User.create(name: 'Sophia Lee', photo: "https://i.pravatar.cc/150?img=#{numbers.pop}", bio: 'Lover of nature, hiking, and sustainable living.')

User.all.each do |user|
    (rand(0..5)*2).times do |i|
      Post.create(
        title: "Post #{i + 1} by ",
        text: "This is the content of Post #{i + 1} created by #{user.name}.",
        author: user
      )
    end
  end

  Post.all.each do |post|
    (rand(0..10)*2).times do |i|
      Comment.create(
        user: User.all.sample,
        post: post,
        text: "This is comment #{i + 1} on #{post.title}#{post.author.name}."
      )
    end
    rand(0..User.all.count).times do |i|
      Like.create(
        user: User.all.sample,
        post: post
      )
    end
  end

        