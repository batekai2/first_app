source 'https://rubygems.org'

ruby '~> 3.2.3'

gem 'rails', '~> 8.1.1'
gem 'propshaft'
gem 'pg', group: :production
gem 'sqlite3', '>= 2.1', groups: %i[development test]
gem 'puma', '>= 7.0.4'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'bcrypt', '~> 3.1.7'
gem 'rack-attack'
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
