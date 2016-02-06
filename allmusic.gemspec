# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "allmusicgenre"
  spec.version       = '1.0'
  spec.author        = "Richard Lyon"
  spec.email         = "richard@richardlyon.net"
  spec.homepage      = "http:/www.homepage.com"
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.license       = "MIT"

  spec.files         = ['lib/allmusicgenre.rb']
  spec.executables   = ['bin/allmusicgenre']
  spec.test_files    = ['tests/test_allmusicgenre.rb']
  spec.require_paths = ["lib"]
end
