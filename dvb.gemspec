# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dvb/version'

Gem::Specification.new do |spec|
  spec.name          = 'dvb'
  spec.version       = DVB::VERSION
  spec.authors       = ['Kilian Koeltzsch']
  spec.email         = ['me@kilian.io']

  spec.summary       = %q{Query Dresden's public transport system for current bus- and tramstop data}
  spec.description   = %q{Query Dresden's public transport system for current bus- and tramstop data}
  spec.homepage      = 'https://github.com/kiliankoe/dvbrb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 2.0'
  spec.add_runtime_dependency 'geokit', '~> 1.10'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0.3'
  spec.add_development_dependency 'webmock'
end
