class ChangeSomeRepoFieldsName < ActiveRecord::Migration[6.0]
  def change
    rename_column :profiles, :public_repos, :public_repos_count
    rename_column :profiles, :public_gists, :public_gists_count
    rename_column :profiles, :followers, :followers_count
    rename_column :profiles, :followings, :followings_count
  end
end
