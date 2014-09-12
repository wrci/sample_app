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
		@attr = { :nom => "Example User", :email => "user@exampple.com" }
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

end
