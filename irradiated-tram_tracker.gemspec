# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'irradiated/tram_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "irradiated-tram_tracker"
  spec.version       = Irradiated::TramTracker::VERSION
  spec.authors       = ["Justin Morris"]
  spec.email         = ["justin@pixelbloom.com"]
  spec.description   = %q{}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "handsoap"
  spec.add_dependency "curb"
  spec.add_dependency "nokogiri"
  spec.add_dependency "sprockets-coffee-react"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
