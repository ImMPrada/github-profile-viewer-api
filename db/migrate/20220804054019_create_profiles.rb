class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nickname, null: false, unique: true
      t.string :avatar, null: false
      t.string :url, null: false
      t.string :repos_url, null: false
      t.string :name
      t.string :company
      t.string :blog
      t.string :email
      t.string :bio
      t.string :twitter
      t.integer :public_repos, null: false
      t.integer :public_gists, null: false
      t.integer :followers, null: false
      t.integer :followings, null: false
      t.date :git_date, null: false
      t.references :location, null: false, foreign_key: true
    end
  end
end
