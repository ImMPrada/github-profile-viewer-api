FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.name }
    amount { Faker::Number.between(from: 1, to: 100) }
    repo_name { Faker::ProgrammingLanguage.name }
  end
end
