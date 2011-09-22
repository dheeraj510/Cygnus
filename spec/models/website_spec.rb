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
end
