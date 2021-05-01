require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  
  describe "GET #index" do
    before :each do
      @url = FactoryBot.create(:url)
      @user = FactoryBot.create(:user)
    end

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

    it "redirects to sign in if user is not signed in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  describe "GET #new" do
    it "render the new template" do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe "GET #create" do
    before :each do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context "with a valid attributes" do
      it "create a new url" do
        expect {
          post :create, params: { url: FactoryBot.attributes_for(:url) }
        }.to change(User, :count).by 1
      end
      
      it "redirects to urls index" do
        post :create, params: { url: FactoryBot.attributes_for(:url, user: @user) }
        expect(response).to redirect_to my_dwarfURLs_path
      end
    end

    context "with an invalid attributes" do
      it "doesn't create a new url" do
        expect {
          post :create, params: { url: { link: nil, _alais: nil, user: nil } }
        }.not_to change(User, :count)
      end
      
      it "re-renders the new method" do
        @user = FactoryBot.create(:user)
        post :create, params: { url: { link: nil, _alais: nil, user: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #show" do
    before :each do
      @url = FactoryBot.create(:url)
    end

    it "assigns @url" do
      get :show, params: { id: @url.id }
      expect(assigns(:url)).to eq @url
    end

    it "redirects to url link" do
      get :show, params: { id: @url.id }
      expect(response).to redirect_to @url.link
    end
  end

  describe "GET #destroy" do
    before :each do
      @user = FactoryBot.create(:user)
      sign_in @user
      @url = FactoryBot.create(:url, user: @user)
    end
    
    it "deletes the url" do
      expect{
        delete :destroy, params: { id: @url.id }        
      }.to change(Url, :count).by -1
    end
    
    it "redirects to url#index" do
      delete :destroy, params: { id: @url.id }        
      expect(response).to redirect_to my_dwarfURLs_path
    end
  end
end