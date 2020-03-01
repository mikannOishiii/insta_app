FactoryBot.define do
  factory :user do
    sequence(:user_name){ |n| "example#{n}" } 
    name "Example User"
    password "foobar"
  end
end
