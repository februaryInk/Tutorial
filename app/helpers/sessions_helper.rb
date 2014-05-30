module SessionsHelper
	def sign_in( user )
		remember_token = User.new_remember_token(  )
		cookies.permanent[ :remember_token ] = remember_token # cookies[ :remember_token ] = { :value => remember_token, :expires => 20.years.from_now utc }
		user.update_attribute( :remember_token, User.digest( remember_token ) )
		self.current_user = user # Converts to current_user=( user ).
	end
	
	def signed_in?(  )
		return( not current_user.nil? )
	end
	
	def current_user=( user )
		@current_user = user
	end
	
	def current_user(  )
		remember_token = User.digest( cookies[ :remember_token ] )
		@current_user ||= User.find_by( { :remember_token => remember_token } ) # Defines @current_user only if it is undefined. That is, @user = @user || <assignment>.
	end
end
