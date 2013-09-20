$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "legelisten_sms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "legelisten_sms"
  s.version     = LegelistenSms::VERSION
  s.authors     = ["Roger Kind Kristiansen"]
  s.email       = ["roger@legelisten.no"]
  s.homepage    = "http://www.legelisten.no"
  s.summary     = "Sending and receiving SMS"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  #s.test_files = Dir["test/**/*"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "delayed_job", "~> 3.0.3"
  s.add_dependency "pswincom"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "sqlite3"
end
