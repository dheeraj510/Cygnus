require 'spec_helper'

describe "Websites" do

  before(:each) do
    user = Factory(:user, :email => "admin@example.com", :admin => true)
    visit signin_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "signup" do

    describe "failure" do

      it "should not make a new website" do
        lambda do
          visit 'websites/new'
          fill_in "Name",         :with => ""
          fill_in "Title",        :with => ""
          click_button
          response.should render_template('websites/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Website, :count)
      end
    end

    describe "success" do

      it "should make a new web site" do
        lambda do
          visit 'websites/new'
          fill_in "Name",         :with => "Example Web Site"
          fill_in "Title",        :with => "An Example Web Site"
          click_button
          response.should have_selector("div.flash.success", :content => "site added")
          response.should render_template('websites/show')
        end.should change(Website, :count).by(1)
      end
    end


  end
  
  
end
