# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :integer
#  commenter_id :integer
#  photo_id     :integer
#
class Comment < ApplicationRecord
  belongs_to(:commenter, { :required => true, :class_name => "User", :foreign_key => "commenter_id" })
  belongs_to(:photo, { :required => true, :class_name => "Photo", :foreign_key => "photo_id", :counter_cache => true })

  validates(:photo_id, { :presence => true })
  validates(:commenter_id, { :presence => true })
  validates(:body, { :presence => true })
end
