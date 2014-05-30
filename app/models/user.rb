class User < ActiveRecord::Base
	Valid_Email_Regex = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	
	before_create( :create_remember_token )
	before_save(  ) { self.email = email.downcase }

	validates( :name, { :presence => true, :length => { :maximum => 50 } } )
	validates( :email, { :presence => true, :format => { :with => Valid_Email_Regex }, :uniqueness => { :case_sensitive => false } } )
	validates( :password, { :length => { :minimum => 6 } } )
	
	has_secure_password(  )
	
	def User.new_remember_token(  )
		SecureRandom.urlsafe_base64(  )
	end
	
	def User.digest( token )
		Digest::SHA1.hexdigest( token.to_s )
	end
	
	private
	
		def create_remember_token(  )
			self.remember_token = User.digest( User.new_remember_token )
		end
end
