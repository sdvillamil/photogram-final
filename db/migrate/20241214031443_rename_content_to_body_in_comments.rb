class RenameContentToBodyInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :content, :body
  end
end
