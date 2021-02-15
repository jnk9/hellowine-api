require 'rails_helper'
RSpec.describe Api::UsersController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
 
    it "assigns @users" do
      user = User.create!(email: 'test-user@email.cl', name: 'test uset 1')
      get :index
      expect(assigns(:users)).to eq([user])
    end

  end
end