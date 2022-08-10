module Sync
  class ReposSync
    attr_accessor :github_repos, :profile, :repos, :github_repo

    def initialize(profile, github_repos)
      self.profile = profile
      self.repos = profile.repos
      self.github_repos = github_repos
    end

    def create_repos
      github_repos.each do |github_repo|
        self.github_repo = github_repo
        new_repo = Repo.new
        fetch_data new_repo
        fetch_profile new_repo
        fetch_date new_repo

        new_repo.save
      end
    end

    private

    def fetch_data(this_repo)
      this_repo.name = github_repo[:name]
      this_repo.url = github_repo[:url]
      this_repo.description = github_repo[:description]
      this_repo.languages_url = 'this will be not used'
      this_repo.is_active = true

      this_repo
    end

    def fetch_profile(this_repo)
      this_repo.profile = profile

      this_repo
    end

    def fetch_date(this_repo)
      this_repo.git_date = Date.parse github_repo[:git_date]

      this_repo
    end
  end
end
