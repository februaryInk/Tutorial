class User < ActiveRecord::Base
	Valid_Email_Regex = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	
	before_save(  ) { self.email = email.downcase }

	validates( :name, { :presence => true, :length => { :maximum => 50 } } )
	validates( :email, { :presence => true, :format => { :with => Valid_Email_Regex }, :uniqueness => { :case_sensitive => false } } )
	validates( :password, { :length => { :minimum => 6 } } )
	
	has_secure_password(  )
end
