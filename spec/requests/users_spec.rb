require 'spec_helper'

describe "Users" do

  describe "signup" do

     describe "failure" do

      it "should not make a new user" do
        lambda do
          #first log in a admin user
          @website = Factory(:website)
          @admin_attr = { :email => "admin@example.com", :password => "foobar00", :password_confirmation => "foobar00" }
          @admin = @website.users.create(@admin_attr)
          @website.website_admins.create(:admin_id => @admin)

          visit signin_path
          fill_in :email,    :with => @admin.email
          fill_in :password, :with => @admin.password
          click_button
          controller.should be_signed_in
          
          #Now you can try to add a new user
          visit 'users/new'
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
          
        #The factory for admin creates 1 user. There should only be that one user created in this block so the 'end' should only have 1 user removed
        end.should change(User, :count).by(1)
      end
    end
      
    describe "success" do

      it "should make a new user" do
        lambda do
          #first log in a admin user
          @website = Factory(:website)
          @admin_attr = { :email => "admin@example.com", :password => "foobar00", :password_confirmation => "foobar00" }
          @admin = @website.users.create(@admin_attr)
          @website.website_admins.create(:admin_id => @admin)
         
          visit signin_path
          fill_in :email,    :with => @admin.email
          fill_in :password, :with => @admin.password
          click_button
          controller.should be_signed_in
          
          #Now you can try to add a new user
          visit 'users/new'
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar0011"
          fill_in "Confirmation", :with => "foobar0011"
          click_button
          response.should have_selector("div.flash.success", :content => "New user")
          response.should render_template('users/show')


        #The factory for admin creates 1 user. That plus the new user means that 'end' should have 2 user's removed
        end.should change(User, :count).by(2)
      end
    end

  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end


end
