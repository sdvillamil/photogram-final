# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :bigint
#  sender_id    :bigint
#
# Indexes
#
#  index_follow_requests_on_recipient_id  (recipient_id)
#  index_follow_requests_on_sender_id     (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class FollowRequest < ApplicationRecord
  belongs_to(:sender, class_name: "User", foreign_key: "sender_id")
  belongs_to(:recipient, class_name: "User", foreign_key: "recipient_id")


  scope :pending, -> { where(status: nil) }

  validates :status, presence: true

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "pending"
  end
end
