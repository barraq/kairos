class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.date :date
      t.references :user, index: true
      t.float :duration
      t.integer :group
      t.integer :project
      t.integer :issue

      t.timestamps
    end
  end
end
