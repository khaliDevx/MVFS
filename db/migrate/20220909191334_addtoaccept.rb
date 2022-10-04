class Addtoaccept < ActiveRecord::Migration[7.0]
  def change
    add_column :accepts, :done, :boolean, :defulet => false
  end
end
