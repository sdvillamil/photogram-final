# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  caption    :text
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#
class Photo < ApplicationRecord
  
  has_many(:comments, class_name: "Comment", foreign_key: "photo_id")
  belongs_to(:poster, class_name: "User", foreign_key: "owner_id")
  has_many(:fans, through: :likes, source: :fan)
  has_many(:likes, class_name: "Like", foreign_key: "photo_id")

  mount_uploader :image, ImageUploader
end
