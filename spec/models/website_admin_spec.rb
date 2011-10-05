require 'spec_helper'

describe WebsiteAdmin do
  
  before(:each) do
    @website = Factory(:website)
    @user_attr = { :email => "user@example.com", :password => "foobar11", :password_confirmation => "foobar11" }
    @user = @website.users.create(@user_attr)
    @website_admin = @website.website_admins.build(:admin_id => @user)
  end
  
  it "should create a new instance given valid attributes" do
    @website_admin.save!
  end

  describe "admin methods" do
  
    before(:each) do
      @website_admin.save
    end
    
    it "should have a web site attribute" do
      @website_admin.should respond_to(:website)
    end

    it "should have the correct web site attribute" do
      @website_admin.website.should  == @website
    end
    
    it "should have a admin attribute" do
      @website_admin.should respond_to(:admin)
    end

    it "should have the correct admin attribute" do
      @website_admin.admin.should  == @user
    end
  end
  
  describe "validations" do
    
    it "should require a website_id" do
      @website_admin.website_id = nil
      @website_admin.should_not be_valid
    end
    
    it "should require a admin_id" do
      @website_admin.admin_id = nil
      @website_admin.should_not be_valid
    end
  end
end
