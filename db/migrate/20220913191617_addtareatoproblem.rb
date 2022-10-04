class Addtareatoproblem < ActiveRecord::Migration[7.0]
  def change
    add_reference :problems, :area, foreign_key: true
    remove_column :users, :area_id
  end
end
