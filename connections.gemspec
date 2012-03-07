$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "connections/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "connections"
  s.version     = Connections::VERSION
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@balvig.com"]
  s.homepage    = "https://github.com/balvig/connections"
  s.summary     = "Connections allows you to easily add follow/like/subscribe/watch/stalk capabilities to any model"
  s.description = "Connections allows you to easily add follow/like/subscribe/watch/stalk capabilities to any model"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"

  s.add_development_dependency "sqlite3"
end
