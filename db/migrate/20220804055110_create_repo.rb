class CreateRepo < ActiveRecord::Migration[6.0]
  def change
    create_table :repos do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :description
      t.string :languages_url, null: false
      t.boolean :is_active
      t.date :git_date, null: false
      t.references :profile, null: false, foreign_key: true
    end
  end
end
