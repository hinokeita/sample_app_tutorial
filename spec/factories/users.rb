FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { "test1@example.com"}
    password { "password" }
    password_confirmation { "password" }
    activated {true}
    activated_at {Time.zone.now}
  end
end
