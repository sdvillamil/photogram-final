# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer          default(0)
#  image          :string
#  likes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  
  has_many(:comments, class_name: "Comment", foreign_key: "photo_id")
  belongs_to(:poster, class_name: "User", foreign_key: "owner_id")
  has_many(:fans, through: :likes, source: :fan)
  has_many(:likes, class_name: "Like", foreign_key: "photo_id")

  mount_uploader :image, ImageUploader
  validates :image, presence: true

end
