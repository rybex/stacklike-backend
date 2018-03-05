source 'https://rubygems.org'

ruby '2.5.0'

gem 'omniauth-google-oauth2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'rails', '~> 5.1.5'
gem 'rails_event_store'

group :development, :test do
  gem 'database_cleaner'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'pry'
  gem 'rails_event_store-rspec'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'timecop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
