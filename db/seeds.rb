# ユーザー
User.create!(name:  "Example User",
             user_name: "example",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  user_name = "example-#{n+1}"
  password = "password"
  User.create!(name:  name,
               user_name: user_name,
               password:              password,
               password_confirmation: password)
end

# マイクロポスト
users = User.order(:created_at).take(6)
3.times do
  image_path = File.join(Rails.root, "test/fixtures/images/sample.jpg")
  text = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(picture: File.new(image_path), text: text) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# お気に入り
posts = Post.all
user  = User.first
fav_posts = posts[2..5]
fav_posts.each { |fav_post| user.like(fav_post) }

# コメント
users = User.all
comment_users = users[2..6]
post = Post.first
content = Faker::Lorem.sentence(5)
comment_users.each { |user| user.comments.create!(content: content, post_id: post.id) }