FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.name }
    amount { Faker::Number.between(from: 1, to: 100) }
  end
end
