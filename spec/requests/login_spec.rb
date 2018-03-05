require 'rails_helper'

RSpec.describe "login page", :type => :feature do
  describe "visiting the login page", :type => :feature do

    it "displays a splash page and sign modal" do
      visit root_path

      within('#login-form-container') do
        expect(page).to have_content 'welcome to chortle'
        expect(page).to have_field("username", placeholder: "username")
        expect(page).to have_field("password", placeholder: "password")
        expect(page).to have_button 'log in'
      end
    end
  end

  describe "the signin process", :type => :feature do
    before :each do
      @user = User.create(username: 'username', password: 'password')
    end

    it "signs me in" do
      visit root_path
      within("#login-form-container") do
        fill_in 'session[username]', with: 'username'
        fill_in 'session[password]', with: 'password'
      end
      click_button 'log in'

      #   assert_select ".header .username", :text => "jdoe" - future assertions
      expect(page).to have_content "logged in: #{@user.username}"
      expect(page).to have_content "signed in as #{@user.username}"
      expect(page).to have_content "log out"
    end

    it "fails to sign me in with invalid credentials" do
      visit root_path
      within("#login-form-container") do
        fill_in 'session[username]', with: 'username1'
        fill_in 'session[password]', with: 'password2'
      end
      click_button 'log in'
      expect(page).to have_content "login failed"
      expect(page).not_to have_content "logged in: #{@user.username}"
      expect(page).not_to have_content "signed in as #{@user.username}"
      expect(page).not_to have_content "log out"
    end
  end
end