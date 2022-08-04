class AddIndexToReposAndLanguages < ActiveRecord::Migration[6.0]
  def change
    add_index :repos, :name
    add_index :languages, :name
  end
end
