FactoryBot.define do
  factory :tweet do
    body { Faker::Lorem.paragraph }
  end
end