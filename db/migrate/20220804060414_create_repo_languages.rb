class CreateRepoLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :repo_languages do |t|
      t.references :repo, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
    end
  end
end
