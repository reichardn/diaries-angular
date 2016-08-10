class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :diary_id
      t.integer :project_id
      t.integer :minutes
      t.integer :day

      t.timestamps null: false
    end
  end
end
