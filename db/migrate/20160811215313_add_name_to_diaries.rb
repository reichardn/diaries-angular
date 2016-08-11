class AddNameToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :name, :string, default: 'placeholder name'
  end
end
