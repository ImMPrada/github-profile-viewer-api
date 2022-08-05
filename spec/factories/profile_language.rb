FactoryBot.define do
  factory :profile_language do
    association :profile
    association :language
  end
end
