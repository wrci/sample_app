require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
render_views
  
  before(:each) do
  	@base_title = "Simple App du Tutoriel Ruby on Rails"
  end
  
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get :new
      assert_select  "title", @base_title+" | Inscription"
    end
  end
  
  describe "GET 'show'" do
  	
  	before(:each) do
  		@user=FactoryGirl.create(:user)
  	end
  	
  	it "devrait réussir" do
  		get :show, :id => @user
  		expect(response).to have_http_status(:success)
  	end
  	
  	it "devrait trouver le bon utilisateur" do
  		get :show, :id => @user
  		expect(assigns(:user)).to  eq(@user)
  	end
  	
  	it "devrait avoir le bon titre" do
  		get :show, :id => @user
  		assert_select "title", "#{@base_title} | #{@user.nom}"
  	end
  	
  	it "devrait inclure le nom d'utilisateur" do
  		get :show, :id => @user
  		assert_select "h1", @user.nom
  	end
  	
  	it "devrait avoir une image de profil" do
  		get :show, :id => @user
  		assert_select "h1" do
  			assert_select  "img [class=?]", "gravatar"
  		end
  	end
  
  end

end
