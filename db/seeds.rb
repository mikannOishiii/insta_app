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