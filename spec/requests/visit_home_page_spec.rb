require 'rails_helper'

RSpec.describe "home page", :type => :feature do
  describe "visiting the home page", :type => :feature do

    it "displays a splash page and login modal" do
      visit '/'

      expect(page).to have_content 'welcome to chortle'
      # expect(page).to have_field("username")
      # expect(page).to have_field("password")
      expect(page).to have_field("username", placeholder: "username")
      expect(page).to have_field("password", placeholder: "password")
      expect(page).to have_button 'log in'
    end
  end

  # describe "the signin process", :type => :feature do
  #   before :each do
  #     User.make(email: 'user@example.com', password: 'password')
  #   end

  #   it "signs me in" do
  #     visit '/sessions/new'
  #     within("#session") do
  #       fill_in 'Email', with: 'user@example.com'
  #       fill_in 'Password', with: 'password'
  #     end
  #     click_button 'Sign in'
  #     expect(page).to have_content 'Success'
  #   end
  # end


  # it "displays the user's username after successful login" do
  #   user = User.create!(:username => "jdoe", :password => "secret")
  #   get "/login"
  #   assert_select "form.login" do
  #     assert_select "input[name=?]", "username"
  #     assert_select "input[name=?]", "password"
  #     assert_select "input[type=?]", "submit"
  #   end

  #   post "/login", :username => "jdoe", :password => "secret"
  #   assert_select ".header .username", :text => "jdoe"
  # end
end