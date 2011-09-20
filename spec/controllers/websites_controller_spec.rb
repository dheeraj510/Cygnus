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

  describe "POST 'create'" do

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
    
    describe "success" do

      before(:each) do
        @attr = { :name => "Test Example Web Site", :title => "A Test Example Website"}
      end

      it "should create a website" do
        lambda do
          post :create, :website => @attr
        end.should change(Website, :count).by(1)
      end

      it "should redirect to the website show page" do
        post :create, :website => @attr
        response.should redirect_to(website_path(assigns(:website)))
      end    
    end
  end  
  
  describe "GET 'edit'" do

    before(:each) do
      @website = Factory(:website)
    end

    it "should be successful" do
      get :edit, :id => @website
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @website
      response.should have_selector("title", :content => "Edit Web Site")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @website = Factory(:website)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :title => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @website, :website => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @website, :website => @attr
        response.should have_selector("title", :content => "Edit Web Site")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Web Site", :title => "A New Web Site" }
      end

      it "should change the web site's attributes" do
        put :update, :id => @website, :website => @attr
        @website.reload
        @website.name.should  == @attr[:name]
        @website.title.should == @attr[:title]
      end

      it "should redirect to the website show page" do
        put :update, :id => @website, :website => @attr
        response.should redirect_to(website_path(@website))
      end

      it "should have a flash message" do
        put :update, :id => @website, :website => @attr
        flash[:success].should =~ /updated/
      end
    end
  end


end
