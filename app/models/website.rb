# == Schema Information
#
# Table name: websites
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Website < ActiveRecord::Base
  attr_accessible :name, :title
  
  has_many :users, :dependent => :destroy
  has_many :website_admins, :dependent => :destroy
  
  validates :name, :presence => true
  validates :title, :presence => true
  
  def admin?(user)
    self.website_admins.find_by_admin_id (user.id)
  end
end
