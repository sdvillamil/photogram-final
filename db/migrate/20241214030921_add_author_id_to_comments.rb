class AddAuthorIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :author_id, :bigint
    add_foreign_key :comments, :users, column: :author_id
  end
end
