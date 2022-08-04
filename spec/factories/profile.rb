FactoryBot.define do
  factory :profile do
    association :location
    nickname { Faker::Name.first_name }
    avatar { 'asdas' }
    url { 'ada' }
    repos_url { 'sadas' }
    public_repos { Faker::Number.between(from: 1, to: 30) }
    public_gists { Faker::Number.between(from: 1, to: 30) }
    followers { Faker::Number.between(from: 1, to: 10) }
    followings { Faker::Number.between(from: 1, to: 20) }
    git_date { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
  end
end
