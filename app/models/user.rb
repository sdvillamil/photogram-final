# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  comments_count         :integer          default(0)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer          default(0)
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  
  has_many(:sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy)
  has_many(:received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy)
  has_many(:own_photos, class_name: "Photo", foreign_key: "owner_id", dependent: :destroy)
  has_many(:comments, class_name: "Comment", foreign_key: "author_id", dependent: :destroy)
  has_many(:likes, class_name: "Like", foreign_key: "fan_id", dependent: :destroy)
  has_many :liked_photos, through: :likes, source: :photo

  
  #conditional relationships
  has_many :followers, -> { where(follow_requests: { status: "accepted" }) }, through: :received_follow_requests, source: :sender
  has_many :following, -> { where(follow_requests: { status: "accepted" }) }, through: :sent_follow_requests, source: :recipient

  validates :username, presence: true, uniqueness: true

  #conditional relationship status
  def following?(other_user)
    following.exists?(id: other_user.id)
  end

  def pending_follow_request?(other_user)
    sent_follow_requests.exists?(recipient_id: other_user.id, status: "pending")
  end

  def followed_by?(other_user)
    followers.exists?(id: other_user.id)
  end

  def pending_follow_request_from?(other_user)
    received_follow_requests.exists?(sender_id: other_user.id, status: "pending")
  end
  


  
  #devise instructions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  

end
