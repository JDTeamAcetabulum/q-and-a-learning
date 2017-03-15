source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Used for password encryption
gem 'bcrypt', '~> 3.1.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Set the templating engine to haml
gem "haml-rails", '~> 0.9'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Postgres database support
gem 'pg', '~> 0.20.0'

# Use npm/gulp to do the frontend build
gem 'npm-pipeline-rails', '~> 1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# ASSET GEMS

# Data visualization library
gem 'd3-rails', '4.7.0'
# Fancy tables with datatables
gem 'jquery-datatables-rails', '~> 3.4.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Lightweight css boilerplate
gem 'skeleton-rails', :git => 'https://github.com/helios-technologies/skeleton-rails'

# ENVIRONMENT-SPECIFIC GEMS

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  # Plugin to generate output parsable by continuous integration
  gem 'coveralls', require: false
  # CI support for minitest
  gem 'minitest-ci'
  # Integration testing for controllers
  gem 'rails-controller-testing'
  # Coverage report generator
  gem 'simplecov', require: false
end
