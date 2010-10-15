require File.expand_path("../lib/messy/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "messy"
  s.version     = Messy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Piotr Chmolowski"]
  s.email       = ["piotr.chmolowski@polcode.com"]
  s.homepage    = "http://github.com/pederbl/messy"
  s.summary     = "A new gem templates"
  s.description = "You're definitely going to want to replace a lot of this"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "messy"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["messy"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end