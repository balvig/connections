$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "connections/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "connections"
  s.version     = Connections::VERSION
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@balvig.com"]
  s.homepage    = "http://balvig.github.com/connections"
  s.summary     = "A simple set of helpers allowing you to easily add follow/like/watch/stalk capabilities to any ActiveRecord model"
  s.description = "A simple set of helpers allowing you to easily add follow/like/watch/stalk capabilities to any ActiveRecord model"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"

  s.add_development_dependency "sqlite3"
end
