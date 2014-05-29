FactoryGirl.define(  ) do
	factory( :user ) do
		name					"Alpha Beta"
		email					"alphabeta@example.com"
		password				"deltaepsilon"
		password_confirmation	"deltaepsilon"
	end
end