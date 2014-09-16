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
  
  describe "POST 'create'" do
  	describe "échec" do
  		before(:each) do
  			@attr = { :nom => "", :email => "", :password => "",
  												:password_confirmation => "" }
  		end
  		
  		it "ne devrait pas créer d'utilisateur" do
  			expect {post :create, :user => @attr}.to_not change(User, :count)
  		end
  		
  		it "devrait avoir le bon titre" do
  			post :create, :user => @attr
  			assert_select  "title", @base_title+" | Inscription"
  		end
  		
  		it "devrait rendre la page 'new'" do
  			post :create, :user => @attr
  			expect(response).to render_template('new')
  		end
    end
    
    describe "succès" do
    	
    	before(:each) do
        	@attr = { :nom => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
        end
        it "devrait créer un utilisateur" do
        	expect {post :create, :user => @attr}.to change(User, :count).by(1)
        end
        
        it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        	post :create, :user => @attr
        	expect(response).to redirect_to(user_path(assigns(:user)))
        end
        
        it "devrait avoir un message de bienvenue" do
        	post :create, :user => @attr
        	expect(flash[:success]).to match(/Bienvenue dans l'Application Exemple/)
        end    
    end
    
  end

end
