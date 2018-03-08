require 'rails_helper'

RSpec.describe "signup page", :type => :feature do
  describe "visiting the signup page", :type => :feature do

    it "displays a signup modal" do
      visit root_path

      expect(page).to have_content 'create an account'
      expect(page).to have_field("username", placeholder: "username")
      expect(page).to have_field("password", placeholder: "password")
      expect(page).to have_field("password confirmation", placeholder: "password confirmation")
      expect(page).to have_button 'log in'
    end
  end

  describe "the account creation process", :type => :feature do
    it "allows me to create an account" do
      visit root_path

      within("#create-user-form-container") do
        fill_in 'user[username]', with: 'username'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end
      click_button 'create account'
      #   assert_select ".header .username", :text => "jdoe" - future assertions
      expect(page).to have_content "new account: username"
      expect(page).to have_content "signed in as username"
      expect(page).to have_content "log out"
      expect(User.count).to eq(1)
    end

    it "fails to create an account without required credentials" do
      visit root_path

      within("#create-user-form-container") do
        fill_in 'user[username]', with: 'username'
        fill_in 'user[password]', with: 'password'
      end
      click_button 'create account'

      expect(page).to have_content "account creation failed:"
      expect(page).not_to have_content "new account: username"
      expect(page).not_to have_content "signed in as username"
      expect(page).not_to have_content "log out"
      expect(User.count).to eq(0)
    end
  end
end