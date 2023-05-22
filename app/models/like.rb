# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#  user_id    :integer
#
class Like < ApplicationRecord

  #direct
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:photo, { :required => true, :class_name => "Photo", :foreign_key => "photo_id", :counter_cache => true })

  #validations
  validates(:user_id, { :presence => true })
  validates(:photo_id, { :presence => true })
  validates(:photo_id, { :uniqueness => { :scope => ["user_id"], :message => "already liked" } })

end
