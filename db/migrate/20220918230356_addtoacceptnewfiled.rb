class Addtoacceptnewfiled < ActiveRecord::Migration[7.0]
  def change
    add_column :accepts, :In_progress, :boolean, :default => true 

  end
end
