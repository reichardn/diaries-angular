class AddCurrentDiaryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_diary_id, :integer
  end
end
