module Sync
  class FetchLanguages
    attr_accessor :github_repo_languages, :repo, :profile

    def initialize(profile, repo)
      self.profile = profile
      self.repo = repo
      self.github_repo_languages = Github::RepoLanguagesConsumer.new(profile.nickname, repo.name).call
    end

    def call
      github_repo_languages.each do |github_repo_language|
        Sync::SyncLanguage.new(profile, repo, github_repo_language).create_language
      end
      profile.reload
      repo.reload
    end
  end
end
