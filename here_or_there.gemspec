require File.expand_path( "../lib/here_or_there/version", __FILE__ )

Gem::Specification.new do |s|

  s.name          = 'here_or_there'
  s.version       = HereOrThere::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = ''
  s.description   = %q{}
  s.authors       = ["Steven Sloan"]
  s.email         = ["stevenosloan@gmail.com"]
  s.homepage      = "http://github.com/stevenosloan/here_or_there"
  s.license       = 'MIT'

  s.files         = Dir["{lib}/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"

end