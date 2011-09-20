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
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Add a new web site")
    end
  end

  describe "POST 'new'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :title => "" }
      end

      it "should not create a web site" do
        lambda do
          post :create, :website  => @attr
        end.should_not change(Website, :count)
      end

      it "should have the right title" do
        post :create, :website => @attr
        response.should have_selector("title", :content => "Add a new web site")
      end

      it "should render the 'new' page" do
        post :create, :website => @attr
        response.should render_template('new')
      end
    end
    
  end

end
