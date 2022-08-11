module Github
  class RepoLanguagesConsumer
    attr_accessor :repo_name, :github_repo_languages, :github_repo_languages_response_code

    def initialize(user_name, repo_name)
      self.repo_name = repo_name
    end

    def call
      [
        { name: 'JavaScript', amount: 19098, repo_name: 'art_musseum' },
        { name: 'SCSS', amount: 3184, repo_name: 'art_musseum' },
        { name: 'HTML', amount: 220, repo_name: 'art_musseum' },
        { name: 'Ruby', amount: 37775, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'HTML', amount: 25212, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'JavaScript', amount: 20719, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'SCSS', amount: 10922, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'Slim', amount: 774, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'CSS', amount: 66, repo_name: 'DEV_Challenges_Recipes_page' },
        { name: 'Ruby', amount: 28708, repo_name: 'dev_practices' },
        { name: 'HTML', amount: 5796, repo_name: 'dev_practices' },
        { name: 'JavaScript', amount: 4587, repo_name: 'dev_practices' },
        { name: 'CSS', amount: 709, repo_name: 'dev_practices' },
        { name: 'TypeScript', amount: 30266, repo_name: 'discussion' },
        { name: 'SCSS', amount: 8897, repo_name: 'discussion' },
        { name: 'HTML', amount: 1721, repo_name: 'discussion' },
        { name: 'Ruby', amount: 26193, repo_name: 'discussion-api' },
        { name: 'HTML', amount: 242, repo_name: 'discussion-api' },
        { name: 'JavaScript', amount: 43784, repo_name: 'github-profile-viewer' },
        { name: 'SCSS', amount: 13737, repo_name: 'github-profile-viewer' },
        { name: 'HTML', amount: 1721, repo_name: 'github-profile-viewer' },
        { name: 'Ruby', amount: 30111, repo_name: 'github-profile-viewer-api' },
        { name: 'HTML', amount: 242, repo_name: 'github-profile-viewer-api' },
        { name: 'Shell', amount: 76, repo_name: 'github-profile-viewer-api' },
        { name: 'Ruby', amount: 30008, repo_name: 'growth-interview' },
        { name: 'JavaScript', amount: 19930, repo_name: 'growth-interview' },
        { name: 'HTML', amount: 5726, repo_name: 'growth-interview' },
        { name: 'SCSS', amount: 4213, repo_name: 'growth-interview' },
        { name: 'TypeScript', amount: 548, repo_name: 'growth-interview' },
        { name: 'JavaScript', amount: 6955, repo_name: 'movies_app' },
        { name: 'SCSS', amount: 4971, repo_name: 'movies_app' },
        { name: 'HTML', amount: 221, repo_name: 'movies_app' },
        { name: 'Ruby', amount: 19386, repo_name: 'movies_app_api' },
        { name: 'HTML', amount: 242, repo_name: 'movies_app_api' },
        { name: 'Ruby', amount: 68804, repo_name: 'our-memories-monolith' },
        { name: 'TypeScript', amount: 41747, repo_name: 'our-memories-monolith' },
        { name: 'HTML', amount: 14816, repo_name: 'our-memories-monolith' },
        { name: 'JavaScript', amount: 1985, repo_name: 'our-memories-monolith' },
        { name: 'SCSS', amount: 1513, repo_name: 'our-memories-monolith' },
        { name: 'CSS', amount: 709, repo_name: 'our-memories-monolith' },
        { name: 'Shell', amount: 127, repo_name: 'our-memories-monolith' },
        { name: 'JavaScript', amount: 18431, repo_name: 'planets' },
        { name: 'SCSS', amount: 8735, repo_name: 'planets' },
        { name: 'HTML', amount: 2690, repo_name: 'planets' },
        { name: 'Ruby', amount: 3041, repo_name: 'ruby_practice' },
        { name: 'TypeScript', amount: 1878, repo_name: 'slack-cryptocurrency-check' }
      ].select { |language| language[:repo_name] == repo_name }
    end
  end
end
