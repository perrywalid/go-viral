class AddCategoriesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :category_id, :integer
  end
end
