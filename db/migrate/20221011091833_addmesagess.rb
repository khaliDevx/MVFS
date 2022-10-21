class Addmesagess < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :message, :boolean, :defulet => false
  end
end
