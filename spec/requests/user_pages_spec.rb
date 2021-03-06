require 'spec_helper.rb'

describe "User pages" do
	let ( :base_title ) { "Ruby on Rails Tutorial Application" }

	subject { page }
	
	describe "index" do
		let( :user ) { FactoryGirl.create( :user ) }
		
		before do
			sign_in( user )
			visit( users_path )
		end
		
		it { should have_title( "All Users" ) }
		it { should have_content( "All Users" ) }
		
		describe "pagination" do
			before( :all ) { 30.times { FactoryGirl.create( :user ) } }
			after( :all ) { User.delete_all(  ) }
			
			it { should have_selector( 'div.pagination' ) }
		
			it "should list each user" do
				User.paginate( page: 1 ).each do | user |
					expect( page ).to have_selector( 'li', text: user.name )
				end
			end
		end
	
		describe "delete links" do
			it { should_not have_link( "Delete" ) }
			
			describe "as an admin user" do
				let( :admin ) { FactoryGirl.create( :admin ) }
				
				before do
					click_link( "Sign Out" ) # Sign out as a regular user, then sign back in as admin?
					sign_in( admin )
					visit( users_path )
				end
				
				it { should have_link( "Delete", href: user_path( User.first ) ) }
				it "should be able to delete another user" do
					expect do
						click_link( "Delete", match: :first )
					end.to change( User, :count ).by( -1 )
				end
				it { should_not have_link( "Delete", href: user_path( admin ) ) }
			end
		end
	end

	describe "signup page" do
		before { visit signup_path }

		it { should have_content( 'Sign Up' ) }
		it { should have_title( "#{ base_title } | Sign Up" ) }
	end
	
	describe "signup" do
		let( :submit ) { "Create My Account" }
		
		before { visit signup_path }
		
		describe "with invalid information" do
			it "should not add to the database of users" do
				expect { click_button submit }.not_to change( User, :count )
			end
			
			describe "after submission" do
				before { click_button submit }
				
				it { should have_title( 'Sign Up' ) }
				it { should have_content( 'error' ) }
			end
		end
		
		describe "with valid information" do
			before do
				fill_in( "Name", { :with => "Example User" } )
				fill_in( "Email", { :with => "user@example.com" } )
				fill_in( "Password", { :with => "epsilon" } )
				fill_in( "Confirm Password", { :with => "epsilon" } )
			end
			
			it "should create a user" do
				expect { click_button submit }.to change( User, :count ).by( 1 )
			end
			
			describe "after saving the user" do
				before { click_button submit }
				let( :user ) { User.find_by( { :email => 'user@example.com' } ) }
				
				it { should have_link( 'Sign Out' ) }
				it { should have_title( user.name ) }
				it { should have_selector( 'div.alert.alert-success', { :text => 'Welcome' } ) }
			end
		end
	end

	describe "profile page" do
		let( :user ) { FactoryGirl.create( :user ) }
		let!( :m1 ) { FactoryGirl.create( :micropost, { :user => user, :content => "Alpha" } ) }
		let!( :m2 ) { FactoryGirl.create( :micropost, { :user => user, :content => "Beta" } ) }
		
		before { visit user_path( user ) }
		
		it { should have_title( user.name ) }
		it { should have_content( user.name ) }
		
		describe "microposts" do
			it { should have_content( m1.content ) }
			it { should have_content( m2.content ) }
			it { should have_content( user.microposts.count ) }
		end
	end
	
	describe "edit" do
		let( :user ) { FactoryGirl.create( :user ) }
		before do
			sign_in( user )
			visit edit_user_path( user )
		end
		
		describe "page" do
			it { should have_content( "Update Your Profile" ) }
			it { should have_title( "Account Settings" ) }
			it { should have_link( 'Change', { :href => 'http://gravatar.com/emails' } ) }
		end
		
		describe "with invalid information" do
			before { click_button( "Save Changes" ) }
			
			it { should have_content( 'error' ) }
		end
		
		describe "with valid information" do
			let( :new_name ) { "New Name" }
			let( :new_email ) { "new@example.com" }
			
			before do
				fill_in( "Name", with: new_name )
				fill_in( "Email", with: new_email )
				fill_in( "Password", with: user.password )
				fill_in( "Confirm Password", with: user.password )
				click_button( "Save Changes" )
			end
			
			it { should have_title( new_name ) }
			it { should have_selector( 'div.alert.alert-success' ) }
			it { should have_link( 'Sign Out', href: signout_path ) }
			specify { expect( user.reload.name ).to eq new_name }
			specify { expect( user.reload.email ).to eq new_email }
		end	
	end
end