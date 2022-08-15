module Sync
  class FetchRepos
    def initialize(profile)
      self.profile = profile
      self.repos = profile.repos
    end

    def call
      github_repos = Github::ReposConsumer.new(profile.nickname).call
      github_repos.each { |github_repo| syncronize_repo(github_repo) }
    end

    private

    attr_accessor :profile, :repos, :repo

    def syncronize_repo(github_repo)
      self.repo = Repo.find_by(name: github_repo[:name])

      create_repo_if_not_exists(github_repo)
      syncronyze_repo(github_repo)
    end

    def create_repo_if_not_exists(github_repo)
      return unless repo.nil?

      self.repo = Sync::SyncRepo.new(profile, github_repo).create_repo
      Sync::FetchLanguages.new(profile, repo).call
    end

    def syncronyze_repo(github_repo)
      this_repo_date = repo.git_date
      github_repo_date = Date.parse(github_repo[:git_date])

      return unless this_repo_date < github_repo_date

      Sync::SyncRepo.new(profile, github_repo).update_repo(repo)
      Sync::FetchLanguages.new(profile, repo).call
    end
  end
end
