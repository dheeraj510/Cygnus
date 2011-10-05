# == Schema Information
#
# Table name: website_admins
#
#  id         :integer         not null, primary key
#  website_id :integer
#  admin_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class WebsiteAdmin < ActiveRecord::Base
  attr_accessible :admin_id
  
  belongs_to :website
  belongs_to :admin, :class_name => "User"
  
  validates :website_id, :presence => true
  validates :admin_id, :presence => true
end
