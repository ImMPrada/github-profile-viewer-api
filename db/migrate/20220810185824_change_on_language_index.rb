class ChangeOnLanguageIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :languages, :name
    add_column :languages, :repo_name, :string, null: false
    add_index :languages, :name
    remove_column :profiles, :repos_url
    remove_column :repos, :languages_url
  end
end
