class AddStatusToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :status, :integer, default: 0
  end
end
