class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
