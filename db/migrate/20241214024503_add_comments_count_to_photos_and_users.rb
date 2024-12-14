class AddCommentsCountToPhotosAndUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :comments_count, :integer, default: 0
    add_column :users, :comments_count, :integer, default: 0
  end
end
