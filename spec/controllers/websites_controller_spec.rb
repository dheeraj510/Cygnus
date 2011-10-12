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

    it "should find the right website" do
      get :show, :id => @website
      assigns(:website).should == @website
    end
  end

  describe "GET 'new'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        @user = Factory(:user, :email => "non_admin@example.com")
        test_sign_in(@user)
        get :new
        response.should redirect_to(root_path)
      end
    end

    describe "as a signed_in admin user" do
      
      before(:each) do
        @admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
      end
      
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Add a new web site")
      end
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :title => "" }
      end

      describe "as a non-signed-in user" do
        it "should deny access" do
          post :create, :website  => @attr
          response.should redirect_to(signin_path)
        end
      end

      describe "as a non-admin user" do
        it "should protect the page" do
          @user = Factory(:user, :email => "non_admin@example.com")
          test_sign_in(@user)
          post :create, :website  => @attr
          response.should redirect_to(root_path)
        end
      end

      describe "as a admin user" do
        
        before(:each) do
          admin = Factory(:user, :email => "admin@example.com", :admin => true)
          test_sign_in(admin)
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
    
    describe "success" do

      before(:each) do
        @attr = { :name => "Test Example Web Site", :title => "A Test Example Website"}
        @admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
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
