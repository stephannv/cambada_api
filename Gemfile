source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'bootsnap', '1.4.5', require: false
gem 'pg', '1.2.2'
gem 'puma', '4.3.1'
gem 'rack-cors', '1.1.1'
gem 'rails', '6.0.2.1'
gem 'tzinfo-data', '1.2.6', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', '11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '5.1.1'
  gem 'faker', '2.2.1'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'rubocop', '0.79.0'
  gem 'rubocop-performance', '1.5.2'
  gem 'rubocop-rails', '2.4.1'
  gem 'spring', '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rspec-rails', '3.9.0'
  gem 'shoulda-matchers', '4.2.0'
  gem 'simplecov', '0.17.1'
end
