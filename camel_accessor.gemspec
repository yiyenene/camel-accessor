
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "camel_accessor/version"

Gem::Specification.new do |spec|
  spec.name          = "camel_accessor"
  spec.version       = CamelAccessor::VERSION
  spec.authors       = ["yiyenene"]
  spec.email         = ["goodbyeboredworld@aol.jp"]

  spec.summary       = "Define Camel Case Named Accessor To Delegate Snake Case Named Accessor"
  spec.homepage      = "https://github.com/yiyenene/camel-accessor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
