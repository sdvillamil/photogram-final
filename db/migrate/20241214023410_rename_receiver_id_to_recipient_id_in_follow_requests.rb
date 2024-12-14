class RenameReceiverIdToRecipientIdInFollowRequests < ActiveRecord::Migration[7.1]
  def change
    rename_column :follow_requests, :receiver_id, :recipient_id
  end
end
