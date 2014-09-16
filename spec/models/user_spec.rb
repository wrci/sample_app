# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do
	before(:each) do
		@attr = {
			:nom => "Example User",
			:email => "user@exampple.com",
			:password => "foobar",
			:password_confirmation => "foobar", 
		}
	end
	
	it "devrait créer une nouvelle isntance dotée des attributs valides" do
		User.create!(@attr)
	end
	
	it "devrait exiger un nom" do
		bad_guy = User.new(@attr.merge(:nom => ""))
		expect(bad_guy).to_not be_valid
	end
	
	it "devrait exiger un mail" do
		bad_guy = User.new(@attr.merge(:email => ""))
		expect(bad_guy).to_not be_valid
	end
	
	it "devrait rejeter les noms trop longs" do
		long_nom = User.new(@attr.merge(:nom => "a"*51))
		expect(long_nom).to_not be_valid
	end
	
	it "devrait accepter une adresse email valide" do
    	adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    	adresses.each do |address|
    		valid_email_user = User.new(@attr.merge(:email => address))
    		expect(valid_email_user).to be_valid
    	end
    end
    
    it "devrait rejeter une adresse email invalide" do
    	adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    	adresses.each do |address|
    		invalid_email_user = User.new(@attr.merge(:email => address))
    		expect(invalid_email_user).to_not be_valid
    	end
    end
    
    it "devrait rejeter un email en double" do
    	User.create!(@attr)
    	user_with_duplicate_email = User.new(@attr)
    	expect(user_with_duplicate_email).to_not be_valid
    end

    it "devrait rejeter un email en double avec une autre casse" do
    	User.create!(@attr.merge(:email => @attr[:email].upcase))
    	user_with_duplicate_email = User.new(@attr)
    	expect(user_with_duplicate_email).to_not be_valid
    end
    
    it "devrait exiger une mot de passe" do
    	expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).to_not be_valid
    end
    
    it "devrait exiger une bonne confirmation" do
    	expect(User.new(@attr.merge(:password_confirmation => "invalide"))).to_not be_valid
    end
    
    it "devrait rejeter les mots de passe trop courts" do
    	court ="a"*5
    	expect(User.new(@attr.merge(:password => court, :password_confirmation => court))).to_not be_valid
    end

	it "devrait rejeter les mots de passe trop longs" do
    	long ="a"*41
    	expect(User.new(@attr.merge(:password => long, :password_confirmation => long))).to_not be_valid
    end
    
    describe "password encryption" do
    	
    	before(:each) do
    		@user = User.create!(@attr)
    	end
    	
    	it "devrait avoir un mot de passe crypté" do
    		expect(@user).to respond_to(:encrypted_password)
    	end
    	
    	it "devrait définir le mot de passe crypté" do
    		expect(@user).to_not be_blank
    	end
    	
    	describe "has password?" do
    	
    	it "doit retourner true si password bon" do
    		expect(@user.has_password?(@user.password)).to be true
    	end
    	
    	it "doit retourner false si password faux" do
    		expect(@user.has_password?("invalide")).to be false
    	end
    	end
    	
    	describe "authenticate method" do

      		it "devrait retourner nul en cas d'inéquation entre email/mot de passe" do
        		wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        		expect(wrong_password_user).to be_nil
      		end

      		it "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
        		nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        		expect(nonexistent_user).to be_nil
      		end

      		it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        		matching_user = User.authenticate(@attr[:email], @attr[:password])
        		expect(matching_user).to eq(@user)
      		end
    end
    
    end
end
