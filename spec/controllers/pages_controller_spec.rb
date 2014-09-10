require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  render_views
  
  before(:each) do
  	@base_title = "Simple App du Tutoriel Ruby on Rails"
  end
  
  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get :home
      assert_select  "title", @base_title+" | Accueil"
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end

    it "devrait avoir le bon titre" do
      get :contact
      assert_select  "title", @base_title+" | Contact"
    end

  end
  
    describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
	
	it "devrait avoir le bon titre" do
      get :about
      assert_select  "title", @base_title+" | A propos"
    end
  end

    
    describe "GET aide" do
    
    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end
    it "devrait avoir le bon titre" do
      get :help
      assert_select  "title", @base_title+" | Aide"
    end
    end

end
