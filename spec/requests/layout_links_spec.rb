require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do

  before(:each) do
  	@base_title = "Simple App du Tutoriel Ruby on Rails"
  end
  
  describe "GET /layout_links" do
  
  it "devrait trouver une page Accueil à '/'" do
    get '/'
    assert_select  "title", @base_title+" | Accueil"
  end

  it "devrait trouver une page Contact at '/contact'" do
    get '/contact'
    assert_select  "title", @base_title+" | Contact"
  end

  it "should have an À Propos page at '/about'" do
    get '/about'
    assert_select  "title", @base_title+" | A propos"
  end

  it "devrait trouver une page Aide à '/help'" do
    get '/help'
    assert_select  "title", @base_title+" | Aide"
  end
  
  it "devrait trouver une page d'inscription à '/signup'" do
  	get '/signup'
  	assert_select "title", @base_title+" | Inscription"
  end
  
  end
end
