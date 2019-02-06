FactoryBot.define do
  factory :micropost do
    content { "I just ate an orange!" }
    after(:build) do |micropost|
      micropost.user = FactoryBot.create(:user)
    end
  end
end
