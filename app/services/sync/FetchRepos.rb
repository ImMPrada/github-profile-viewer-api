module Sync
  class FetchRepos
    attr_accessor :github_repos, :repos, :profile

    def initialize(profile)
      self.profile = profile
      self.repos = profile.repos
      self.github_repos = Github::ReposConsumer.new(profile.nickname).call
    end

    def call
      if repos.size.zero?
        self.repos = Sync::ReposSync.new(profile, github_repos).create_repos
      end

      byebug
    end
  end
end