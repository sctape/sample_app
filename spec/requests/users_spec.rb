require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Test User"
          fill_in "Email",        :with => "testuser@example.com"
          fill_in "Password",     :with => "123456"
          fill_in "Confirmation", :with => "123456"
          click_button
          response.should render_template('users/show')
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
        end.should change(User, :count).by(1)
      end
    end
  end

end
