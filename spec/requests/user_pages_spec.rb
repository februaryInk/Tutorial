require 'spec_helper.rb'

describe "User pages" do
	let ( :base_title ) { "Ruby on Rails Tutorial Application" }

	subject { page }

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
				fill_in( "Password", { :with => "deltaepsilon" } )
				fill_in( "Confirm Password", { :with => "deltaepsilon" } )
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
		before { visit user_path( user ) }
		
		it { should have_title( user.name ) }
		it { should have_content( user.name ) }
	end
end