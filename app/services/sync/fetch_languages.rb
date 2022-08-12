module Sync
  class FetchLanguages
    def initialize(profile, repo)
      self.profile = profile
      self.repo = repo
    end

    def call
      github_repo_languages = Github::RepoLanguagesConsumer.new(profile.nickname, repo.name).call
      github_repo_languages.each do |github_repo_language|
        Sync::SyncLanguage.new(profile, repo, github_repo_language).create_language
      end
      profile.reload
      repo.reload
    end

    private

    attr_accessor :repo, :profile
  end
end
