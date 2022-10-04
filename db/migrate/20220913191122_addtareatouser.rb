class Addtareatouser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :area, foreign_key: true
    
  end
end
