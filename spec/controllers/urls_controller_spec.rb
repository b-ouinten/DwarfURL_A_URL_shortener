require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  before :each do
    @url = FactoryBot.create(:url)
    @user = FactoryBot.create(:user)
  end
  
  describe "GET #index" do
    it "assigns @urls when user is signed in" do
      sign_in @user
      get :index
      expect(assigns(:urls)).to eq @user.urls
    end
    
    it "renders the index template when user is signed in" do
      sign_in @user
      get :index
      expect(response).to render_template 'index'
    end

    it "redirect to sign in if user is not signed in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "GET #new" do
    
  end

  describe "GET #create" do
    
  end

  describe "GET #show" do
    
  end

  describe "GET #destroy" do
    
  end
end