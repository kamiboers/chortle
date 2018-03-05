require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    it "returns http redirect" do
      post :create, :params => { :user => { :username => "username", :password => "password" } }
      expect(response).to have_http_status(:redirect)
      expect(User.count).to eq(1)
      expect(User.last.username).to eq('username')
    end
  end

  describe "PUT #update" do
    it "returns http redirect" do
      user = User.create(username: 'username', password: 'password', id: 123)
      put :update, :params => { :user => { :id => user.id, :username => 'new_username', password: 'new_password' } }
      expect(response).to have_http_status(:redirect)
      expect(user.reload.username).to eq('new_username')
    end
  end

  describe "POST #destroy" do
    it "returns http redirect" do
      user = User.create(username: 'username', password: 'password', id: 123)
      post :destroy, :params => { :user => { :id => user.id } }
      expect(response).to have_http_status(:redirect)
      expect(User.count).to eq(0)
    end
  end

end
