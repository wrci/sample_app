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

end
