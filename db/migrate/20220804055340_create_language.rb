class CreateLanguage < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false
      t.integer :amount, null: false
    end
  end
end
