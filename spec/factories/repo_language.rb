FactoryBot.define do
  factory :repo_language do
    association :repo
    association :language
  end
end
