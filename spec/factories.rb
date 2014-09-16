FactoryGirl.define do
	factory :user do
		nom                   "Michael Hartl"
		email                 "mhartl@example.com"
		password              "foobar"
		password_confirmation "foobar"
	end
end
