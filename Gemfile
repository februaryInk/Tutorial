source 'https://rubygems.org'

gem 'rails',			'4.1.1'		# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sqlite3'						# Use SQLite as the database for Active Record
gem 'sass-rails',		'4.0.3'		# Use SCSS for stylesheets
gem 'uglifier',			'1.3.0'		# Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails',		'4.0.1'		# Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails'					# Use jquery as the JavaScript library
gem 'turbolinks'					# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', 		'2.0.0'		# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'bootstrap-sass',	'2.3.2.0'
gem 'sprockets',		'2.11.0'
gem 'bcrypt-ruby',		'3.1.2'		# Includes password-encrypting function bcrypt


group :development, :test do
	gem 'rspec-rails',	'2.13.1'
end

group :test do
	gem 'selenium-webdriver',	'2.35.1'
	gem 'capybara',				'2.1.0'
	gem 'factory_girl_rails',	'4.2.1'
end

group :doc do
	gem 'sdoc', 	'0.4.0', require: false		# bundle exec rake doc:rails generates the API under doc/api.
end

group :production do
	gem 'pg',				'0.15.1'
	gem 'rails_12factor',	'0.0.2'
end

gem 'tzinfo', platforms: [:x64_mingw, :mingw, :mswin]
gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]		# Windows does not include zoneinfo files, so bundle the tzinfo-data gem