# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "capa"
  spec.version       = "0.0.1"
  spec.authors       = ["ksss"]
  spec.email         = ["co000ri@gmail.com"]
  spec.description   = %q{Capa}
  spec.summary       = %q{Capa}
  spec.homepage      = "https://github.com/ksss/capa"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/capa/extconf.rb"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "gnuplot"
end
