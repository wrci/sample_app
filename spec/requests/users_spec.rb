# require 'rails_helper'
# 
# RSpec.describe "Users", :type => :request do
#   describe "Une inscription" do
# 
#     describe "ratée" do
# 
#       it "ne devrait pas créer un nouvel utilisateur" do
#         lambda do
#           visit signup_path
#           fill_in "Nom", :with => ""
#           fill_in "eMail", :with => ""
#           fill_in "Mot de passe", :with => ""
#           fill_in "Confirmation mot de passe", :with => ""
#           click_button
#           response.should render_template('users/new')
#           response.should have_selector("div#error_explanation")
#         end.should_not change(User, :count)
#       end
#     end
#   end
# end
