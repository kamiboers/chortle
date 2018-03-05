require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    it "returns http success" do
      post :create, :params => { :session => { :username => "username", :password => "password" } }
      
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:redirect)
    end
  end

end
