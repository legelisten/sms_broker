$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sms_broker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sms_broker"
  s.version     = SmsBroker::VERSION
  s.required_ruby_version = '>= 2.2.5'
  s.authors     = ["Roger Kind Kristiansen"]
  s.email       = ["roger@legelisten.no"]
  s.homepage    = "http://www.legelisten.no"
  s.summary     = "Sending and receiving SMS"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  #s.test_files = Dir["test/**/*"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4"
  s.add_dependency "delayed_job", "~> 4"
  s.add_dependency "pswincom", "~>0.1.8"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rubocop', "= 0.41"
  s.add_development_dependency 'reek', "~> 4.1"
end
