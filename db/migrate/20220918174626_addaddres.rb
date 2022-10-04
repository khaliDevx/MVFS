class Addaddres < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :addrees, :string 

  end
end
