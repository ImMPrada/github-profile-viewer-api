module Github
  class ProfileConsumer

    def initialize(user_name)
    end

    def call
      {
        nickname: 'ImMPrada',
        avatar_url: 'https://avatars.githubusercontent.com/u/26731448?v=4',
        url: 'https://github.com/ImMPrada',
        name: 'miguel',
        company: nil,
        blog: 'https://www.linkedin.com/in/immprada/',
        email: nil,
        bio: nil,
        twitter_username: 'im_mprada',
        public_repos_count: 15,
        public_gists_count: 0,
        followers_count: 6,
        following_count: 6,
        git_date: '2022-08-03T00:16:27Z',
        location: 'Colombia'
      }
    end
  end
end
