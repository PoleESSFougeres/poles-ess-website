source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.5'

# Core ====================================================
gem 'rails', '~> 6.1'
gem 'pg'
gem 'puma'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

# DB / Model ==============================================
gem "devise", "~> 4.7"
gem "rails-settings-cached", "~> 2"
gem 'acts_as_list'
gem 'pg_search'

# Views ====================================================
gem 'slim'
gem 'active_link_to'
gem 'kaminari'

# Uploads ================================================
gem 'image_processing'
gem 'active_storage_validations'
gem 'activestorage-openstack'

# Quality =================================================
gem 'rollbar'

# Mail ====================================================
gem 'sib-api-v3-sdk'
gem 'MailchimpMarketing'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "dotenv-rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'i18n-debug'
  gem "letter_opener"
  gem "bullet"
end

group :test do
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  # gem 'faker'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  # gem 'selenium-webdriver'
  # # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  # gem 'email_spec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
