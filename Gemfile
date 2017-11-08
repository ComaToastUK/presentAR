source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', groups: [:development, :test]
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'paperclip', '~> 5.0.0'
gem 'aws-sdk', '~> 2.3'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'simple_form'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec'
  gem 'pry'
end

group :test do
  gem 'database_cleaner'
  gem 'rubocop'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
