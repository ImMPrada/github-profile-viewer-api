FactoryBot.define do
  factory :profile do
    association :location
    nickname { Faker::Name.first_name }
    avatar { 'asdas' }
    url { 'ada' }
    public_repos_count { Faker::Number.between(from: 1, to: 30) }
    public_gists_count { Faker::Number.between(from: 1, to: 30) }
    followers_count { Faker::Number.between(from: 1, to: 10) }
    followings_count { Faker::Number.between(from: 1, to: 20) }
    git_date { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    join_date { Faker::Date.between(from: '2014-01-23', to: '2014-02-25') }
  end
end
