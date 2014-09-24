# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "visualiser"
  spec.version       = '1.0'
  spec.authors       = ["Joshua Jordan"]
  spec.email         = ["joshuansjordan@gmail.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = ""

  spec.files         = ['lib/visualiser.rb']
  spec.executables   = ['bin/visualiser']
  spec.test_files    = ['tests/visualiser_tests.rb']
  spec.require_paths = ["lib"]
end