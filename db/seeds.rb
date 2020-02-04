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
10.times do
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