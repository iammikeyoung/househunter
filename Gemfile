source 'https://rubygems.org'

ruby '2.3.3'

gem 'rails',            '~> 5.1.4'
gem 'pg',               '~> 0.18'
gem 'sass-rails',       '~> 5.0'
gem 'uglifier',         '>= 1.3.0'
gem 'foundation-rails'
gem 'jquery-rails'
# Use ActiveModel has_secure_password
gem 'bcrypt',           '~> 3.1.7'
gem 'carrierwave',      '~> 1.0'
gem 'mini_magick',      '~> 4.8'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy', require: false
  gem 'valid_attribute'
  gem 'shoulda'
  gem 'rails-controller-testing'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen',                 '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
end

group :development, :production do
  gem 'fog'
end

group :production do
  gem 'puma',           '~> 3.7'
  gem 'rails_12factor'
end
