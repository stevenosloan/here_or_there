require File.expand_path( "../lib/here_or_there/version", __FILE__ )

Gem::Specification.new do |s|

  s.name          = 'here_or_there'
  s.version       = HereOrThere::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = 'Unified interface for running local and remote commands'
  s.description   = %q{A unified interface for running local or remote commands. Provides a dependable & identical response from both types of command.}
  s.authors       = ["Steven Sloan"]
  s.email         = ["stevenosloan@gmail.com"]
  s.homepage      = "http://github.com/stevenosloan/here_or_there"
  s.license       = 'MIT'

  s.files         = Dir["{lib}/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"

  s.add_dependency  "net-ssh", [">= 2.6", "< 5"]

end