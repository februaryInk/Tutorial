require 'spec_helper.rb'

describe "User pages" do

	let ( :base_title ) { "Ruby on Rails Tutorial Application" }

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content( 'Sign Up' ) }
		it { should have_title( "#{ base_title } | Sign Up" ) }
		
	end
	
end