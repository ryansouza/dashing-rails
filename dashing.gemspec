$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dashing/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dashing"
  s.version     = Dashing::VERSION
  s.authors     = ["Ryan Souza", "Daniel Beauchamp"]
  s.email       = ["rydsouza@gmail.com", "daniel.beauchamp@shopify.com"]
  s.homepage    = "https://github.com/ryansouza"
  s.summary     = "Dashing but in rails"
  s.description = "Dashing but in rails"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0.rc1"
  s.add_dependency 'coffee-script', '>=1.6.2'
  s.add_dependency 'rufus-scheduler'
  s.add_dependency 'json'

  s.add_development_dependency "sqlite3"
end
