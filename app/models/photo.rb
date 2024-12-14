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

  belongs_to(:poster, class_name: "User", foreign_key: "owner_id")
  mount_uploader :image, ImageUploader
end
