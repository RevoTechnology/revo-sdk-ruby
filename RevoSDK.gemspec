# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'revo_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "revo_sdk"
  spec.version       = RevoSDK::VERSION
  spec.authors       = ["Revo Technologies"]
  spec.email         = ["antony.vorobiev@gmail.com", "mmajorov@gmail.com"]

  spec.summary       = %q(RevoSDK helps to connect and use services of Revo Technologies)
  spec.homepage      = "https://github.com/RevoTechnology/revo-sdk-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
