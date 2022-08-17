FactoryBot.define do
  factory :repo do
    association :profile
    name { "a_repo_called_#{Faker::Name.first_name}" }
    url { 'the repo\'s url' }
    description { 'sadas' }
    git_date { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
  end
end
