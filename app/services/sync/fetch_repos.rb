module Sync
  class FetchRepos
    def initialize(profile)
      self.profile = profile
      self.repos = profile.repos
    end

    def call
      github_repos = Github::ReposConsumer.new(profile.nickname).call

      if repos.size.zero?
        github_repos.each do |github_repo|
          repo = Sync::SyncRepo.new(profile, github_repo).create_repo
          # Sync::FetchLanguages.new(profile, repo).call
        end
      end
    end

    private

    attr_accessor :profile, :repos
  end
end
