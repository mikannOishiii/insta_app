FactoryBot.define do
  factory :user, class: User do
    sequence(:user_name){ |n| "example#{n}" }
    name "Example User"
    password "foobar"
  end

  factory :another_user, class: User do
    sequence(:user_name){ |n| "another#{n}" }
    name "Another User"
    password "foobar"
  end
end
