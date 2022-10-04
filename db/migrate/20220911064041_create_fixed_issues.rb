class CreateFixedIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :fixed_issues do |t|
      t.belongs_to :user
      t.belongs_to :problem
      t.text :description
      t.timestamps
    end
  end
end
