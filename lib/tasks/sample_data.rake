namespace( :db ) do 
	desc "Fill database with sample data"
	task( { :populate => :environment } ) do # Makes task db:populate with access to the local Rails environment
		admin = User.create!( { :name => "Example User", :email => "example@railstutorial.org", :password => "epsilon", :password_confirmation => "epsilon", :admin => true } )
		99.times do | n |
			name = Faker::Name.name
			email = "example-#{ n + 1 }@railstutorial.org"
			password = "password"
			password_confirmation = "password"
			User.create!( { :name => name, :email => email, :password => password, :password_confirmation => password_confirmation } )
		end
	end
end