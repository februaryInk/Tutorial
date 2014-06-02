class UsersController < ApplicationController
	before_action( :signed_in_user, only: [ :index, :edit, :update, :destroy ] ) # Executes always before edit or update methods
	before_action( :correct_user, only: [ :edit, :update ] )
	before_action( :admin_user, only: [ :destroy ] )
	before_action( :not_signed_in_user, only: [ :new, :create ] )
	
	def index(  ) # SHOW
		@users = User.paginate( page: params[ :page ] )
	end

	def new(  ) # SHOW
		@user = User.new(  )
	end
	
	def create(  ) # POST
		@user = User.new( user_params(  ) )
		if ( @user.save(  ) )
			sign_in( @user )
			flash[ :success ] = "Welcome to the Tutorial Application!"
			redirect_to( @user )
		else
			render( 'new' )
		end
	end
  
	def show(  ) # SHOW
		@user = User.find( params[ :id ] )
	end
	
	def edit(  ) # SHOW
	end
	
	def update(  ) # PATCH/PUT
		if ( @user.update_attributes( user_params ) )
			flash[ :success ] = 'Profile updated'
			redirect_to( @user )
		else
			render( 'edit' )
		end
	end
	
	def destroy(  ) # DELETE
		User.find( params[ :id ] ).destroy
		flash[ :success ] = "User deleted."
		redirect_to( users_url )
	end
	
	private
	
		def user_params(  )
			return( params.require( :user ).permit( :name, :email, :password, :password_confirmation ) )
		end
		
		# Before filters
		
		def signed_in_user(  )
			unless signed_in?(  )
				flash[ :notice ] = "Please sign in"
				store_location(  )
				redirect_to( signin_url ) # Or: redirect_to( signin_url, { :notice => "Please sign in." } )
			end
		end
		
		def not_signed_in_user(  )
			if signed_in?(  )
				redirect_to( root_url )
			end
		end
		
		def correct_user(  )
			@user = User.find( params[ :id ] )
			redirect_to( root_url ) unless ( current_user?( @user ) )
		end
		
		def admin_user(  )
			redirect_to( root_url ) unless ( current_user.admin?(  ) )
		end
end
