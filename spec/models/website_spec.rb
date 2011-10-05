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

require 'spec_helper'

describe Website do

  before(:each) do
    @attr = { :name => "Example Website", :title => "This is a example web site" }
  end

  it "should create a new instance given valid attributes" do
    Website.create!(@attr)
  end

  it "should require a name" do
    no_name_website = Website.new(@attr.merge(:name => ""))
    no_name_website.should_not be_valid
  end

  it "should require a title" do
    no_title_website = Website.new(@attr.merge(:title => ""))
    no_title_website.should_not be_valid
  end

  describe "user associations" do
    before(:each) do
      @website = Website.create(@attr)
    end
    
    it"should have users attribute" do
      @website.should respond_to(:users)
    end
  end
  
  describe " admins associations" do
    before(:each) do
      @website = Website.create(@attr)
    end
    
    it "should have website_admins" do
      @website.should respond_to(:website_admins)
    end
    
    it "should respond to admin?" do
      @website.should respond_to(:admin? )
    end

    it  "should return true if user is admin" do
      @user_attr = { :email => "user@example.com", :password => "foobar11", :password_confirmation => "foobar11" }
      @user = @website.users.create(@user_attr)
      @website.website_admins.create(:admin_id => @user)
      @website.admin?(@user).should be_true
    end
    
  end
  
  
end
