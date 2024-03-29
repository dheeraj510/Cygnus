# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :email => "user@example.com", :password => "foobar11", :password_confirmation => "foobar11" }
    @website = Factory(:website)
  end
  
  describe "validations" do
    
    it "should require a website id" do
      User.new(@attr).should_not be_valid
    end
    
    it "should create a new instance given valid attributes" do
      @website.users.create!(@attr)
    end
  
    it "should require an email" do
      no_email_user = @website.users.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = @website.users.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = @website.users.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      # Put a user with given email address into the database.
      @website.users.create!(@attr)
      user_with_duplicate_email = @website.users.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end
  
  describe "website associations" do

    before(:each) do
      @user = @website.users.new(@attr)
    end
    
    it  "should have a website attr" do
      @user.should respond_to(:website)
    end
    
    it "should have the right associated website" do
      @user.website_id.should == @website.id
      @user.website.should == @website
    end
  end
  
  describe "website admins associations" do
    before(:each) do
      @user = @website.users.new(@attr)
    end
    
    it "should have a website_admins method" do
      @user.should respond_to(:website_admins)
    end
   
  end

  
  
  describe "password validations" do

    it "should require a password" do
      @website.users.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      @website.users.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 7
      hash = @attr.merge(:password => short, :password_confirmation => short)
      @website.users.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      @website.users.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = @website.users.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end 
    end
      
    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = @website.users.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

end
