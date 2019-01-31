FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { "test1@example.com"}
    password { "password" }
    password_confirmation { "password" }
  end
end
