module Sync
  class SyncLanguage
    def initialize(profile, repo, repo_language_data)
      self.profile = profile
      self.repo = repo
      self.repo_language_data = repo_language_data
    end

    def create_language
      new_language = Language.new
      assign_attributes new_language
      new_language.save
      fetch_profile_and_repo new_language

      new_language
    end

    private

    attr_accessor :repo_language_data, :repo, :profile

    def assign_attributes(this_language)
      this_language.attributes = repo_language_data
    end

    def fetch_profile_and_repo(this_language)
      RepoLanguage.create(repo: repo, language: this_language)
      ProfileLanguage.create(profile: profile, language: this_language)
    end
  end
end
