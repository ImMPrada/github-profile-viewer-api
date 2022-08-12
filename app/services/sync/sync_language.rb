module Sync
  class SyncLanguage
    def initialize(profile, repo, github_repo_language)
      self.profile = profile
      self.repo = repo
      self.github_repo_language = github_repo_language
    end

    def create_language
      new_language = Language.new
      fetch_data new_language
      new_language.save
      fetch_profile_and_repo new_language

      new_language
    end

    private

    attr_accessor :github_repo_language, :repo, :profile

    def fetch_data(this_language)
      this_language.attributes = github_repo_language
    end

    def fetch_profile_and_repo(this_language)
      RepoLanguage.create(repo: repo, language: this_language)
      ProfileLanguage.create(profile: profile, language: this_language)
    end
  end
end
