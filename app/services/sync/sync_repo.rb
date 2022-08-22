module Sync
  class SyncRepo
    def initialize(profile, repo_data)
      self.profile = profile
      self.repo_data = repo_data
    end

    def create_repo
      self.repo = Repo.new
      assign_attributes true
      assign_repo_profile

      repo.save
      repo
    end

    def update_repo(current_repo)
      self.repo = current_repo
      assign_attributes true

      repo.save
      repo
    end

    def deactivate_repo(current_repo)
      self.repo = current_repo
      assign_attributes false

      repo
    end

    private

    attr_accessor :repo_data, :profile, :repo

    def assign_attributes(is_active)
      repo_params = repo_data.merge(
        is_active: is_active,
        git_date: Date.parse(repo_data[:git_date])
      )
      repo.attributes = repo_params
    end

    def assign_repo_profile
      repo.profile = profile
    end
  end
end
