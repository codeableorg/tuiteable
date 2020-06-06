FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.unique.alpha(number: 10)}
    email { Faker::Internet.unique.email }
    display_name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
    location { Faker::Nation.nationality }
    password {Devise.friendly_token}
  end
end