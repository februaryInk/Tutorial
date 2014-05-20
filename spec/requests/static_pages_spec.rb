require 'spec_helper'

describe "StaticPages" do

	let ( :base_title ) { "Ruby on Rails Tutorial" }

	describe "Home page" do
		it "should have the content \"Tutorial Home Page\"" do
			visit '/static_pages/home'
			expect(page).to have_content('Tutorial Home Page')
		end
	end
	
	it "should have the title \"Home\"" do
		visit '/static_pages/home'
		expect(page).to have_title("#{ base_title } | Home")
	end
  
	describe "Help page" do
		it "should have the content \"Help\"" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
	end

	it "should have the title \"Help\"" do
		visit '/static_pages/help'
		expect(page).to have_title("#{ base_title } | Help")
	end
  
	describe "About page" do
		it "should have the content \"About\"" do
			visit '/static_pages/about'
			expect(page).to have_content('About')
		end
	end

	it "should have the title \"About\"" do
		visit '/static_pages/about'
		expect(page).to have_title("#{ base_title } | About")
	end
	
	describe "Contact Me page" do
		it "should have the content \"Contact Me\"" do
			visit '/static_pages/contact'
			expect(page).to have_content('Contact Me')
		end
	end

	it "should have the title \"Contact\"" do
		visit '/static_pages/contact'
		expect(page).to have_title("#{ base_title } | Contact")
	end
	
end