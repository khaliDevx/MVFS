class Renqametoacceptnewfiled < ActiveRecord::Migration[7.0]
  def change
    rename_column :accepts, :In_progress, :in_progress
  end
end
