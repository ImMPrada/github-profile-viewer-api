FactoryBot.define do
  factory :location do
    name { Faker::Nation.capital_city }
  end
end
