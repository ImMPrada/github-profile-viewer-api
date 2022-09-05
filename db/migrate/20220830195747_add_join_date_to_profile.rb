class AddJoinDateToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :join_date, :date
  end
end
