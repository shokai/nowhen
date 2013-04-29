# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nowhen/version'

Gem::Specification.new do |spec|
  spec.name          = "nowhen"
  spec.version       = NoWhen::VERSION
  spec.authors       = ["Sho Hashimoto"]
  spec.email         = ["hashimoto@shokai.org"]
  spec.description   = %q{Tagger for Life Log}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/shokai/nowhen"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).reject{|i| i == "Gemfile.lock" }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  spec.add_dependency "args_parser"
  spec.add_dependency "data_mapper"
  spec.add_dependency "dm-sqlite-adapter"
  spec.add_dependency "backports"
end
