class AddCategoryIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :category_id, :integer, :null => false, :default => 1
  end
  add_index :books, :category_id
end
