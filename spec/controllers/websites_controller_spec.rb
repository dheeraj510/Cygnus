require 'spec_helper'

describe WebsitesController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @website = Factory(:website)
    end

    it "should be successful" do
      get :show, :id => @website
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @website
      assigns(:website).should == @website
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Add a new web site")
    end

end
