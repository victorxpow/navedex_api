source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'devise'
gem 'devise-jwt'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 4.1.0'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
