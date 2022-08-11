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
        github_repos.each do |github_repo|
          repo = Sync::SyncRepo.new(profile, github_repo).create_repo
          Sync::FetchLanguages.new(profile, repo).call
        end

        profile.reload
      end
    end
  end
end
