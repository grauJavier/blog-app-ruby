# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'Alice Johnson', photo: "https://i.pravatar.cc/150?img=#{rand(1..70)}", bio: 'Passionate about photography and travel.')
User.create(name: 'Ethan Smith', photo: "https://i.pravatar.cc/150?img=#{rand(1..70)}", bio: 'Software developer by day, aspiring musician by night.')
User.create(name: 'Olivia Davis', photo: "https://i.pravatar.cc/150?img=#{rand(1..70)}", bio: 'Bookworm, tea lover, and art enthusiast.')
User.create(name: 'Liam Wilson', photo: "https://i.pravatar.cc/150?img=#{rand(1..70)}", bio: 'Fitness enthusiast and certified personal trainer.')
User.create(name: 'Sophia Lee', photo: "https://i.pravatar.cc/150?img=#{rand(1..70)}", bio: 'Lover of nature, hiking, and sustainable living.')

User.all.each do |user|
    rand(0..5).times do |i|
      Post.create(
        title: "Post #{i + 1} by #{user.name}",
        text: "This is the content of Post #{i + 1} created by #{user.name}.",
        author: user
      )
    end
  end