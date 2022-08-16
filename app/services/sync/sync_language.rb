module Sync
  class SyncLanguage
    def initialize(profile, repo, repo_language_data)
      self.profile = profile
      self.repo = repo
      self.repo_language_data = repo_language_data
    end

    def synchronize
      self.language = repo.languages.find_by(name: repo_language_data[:name])
      self.language = Language.new if language.nil?

      assign_attributes
      language.save
      fetch_profile_and_repo

      language
    end

    private

    attr_accessor :repo_language_data, :repo, :profile, :language

    def assign_attributes
      language.attributes = repo_language_data
    end

    def fetch_profile_and_repo
      RepoLanguage.create(repo: repo, language: language)
      ProfileLanguage.create(profile: profile, language: language)
    end
  end
end
