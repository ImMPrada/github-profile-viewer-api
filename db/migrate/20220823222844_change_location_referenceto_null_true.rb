class ChangeLocationReferencetoNullTrue < ActiveRecord::Migration[6.1]
  def change
    change_column_null :profiles, :location_id, true
  end
end
