source "https://rubygems.org"

# Declare your gem's dependencies in sms_broker.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "jquery-rails"              # Used by the dummy application
gem "pswincom", :git => "git://github.com/legelisten/pswincomgem.git"
gem "delayed_job", '~> 4'
gem 'delayed_job_active_record'

group :development, :test do
  gem 'rspec-rails', '~> 2.0'

  gem 'sqlite3'

  gem 'guard',              require: false
  gem 'guard-spork',        require: false
  gem 'guard-rspec',        require: false
  gem 'guard-bundler',      require: false
end

group :test do
  gem 'factory_girl_rails'

  gem 'vcr', '~> 2.0'                         # Record HTTP interactions
  gem 'webmock'                               # Used by vcr
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
