require 'rails_helper'

RSpec.describe "login page", :type => :feature do
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.username,
                                          password: password,
                                          remember_me: remember_me } }
  end

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

      visit root_path

      expect(page).not_to have_content "signed in as #{@user.username}"
      expect(page).not_to have_content "log out"
    end


    #TODO - test remember_me checkbox and figure out how to post rather than use ui (pt9)

    # it "uses a helper method" do
    #   log_in_as(@user)
    # end

    # it "logs user in with valid information followed by logout" do
    #   visit root_path
    #   post login_path, params: { session: { username: @user.username, 
    #                                         password: @user.password } }
    #   expect(is_logged_in?).to be(true)
    #   # assert_redirected_to root_path
    #   # follow_redirect!
    #   # assert_template 'users/show'
    #   # assert_select "a[href=?]", login_path, count: 0
    #   # assert_select "a[href=?]", logout_path

    #   delete logout_path
    #   expect(is_logged_in?).not_to be(true)
    #   # assert_redirected_to root_url

    #   # Simulate a user clicking logout in a second window.
    #   # delete logout_path
    #   # follow_redirect!
    #   # assert_select "a[href=?]", login_path
    #   # assert_select "a[href=?]", logout_path,      count: 0
    # end

  end
end