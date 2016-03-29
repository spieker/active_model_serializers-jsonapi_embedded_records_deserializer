# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_serializers/jsonapi_embedded_records_deserializer/version'

Gem::Specification.new do |spec|
  spec.name          = "active_model_serializers-jsonapi_embedded_records_deserializer"
  spec.version       = ActiveModelSerializers::JsonapiEmbeddedRecordsDeserializer::VERSION
  spec.authors       = ["Paul Spieker"]
  spec.email         = ["p.spieker@duenos.de"]

  spec.summary       = %q{Deserializing embedded JSONAPI records into ActiveRecord nested attributes (Not part of the JSONAPI spec yet!)}
  spec.homepage      = "https://github.com/spieker/active_model_serializers-jsonapi_embedded_records_deserializer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'active_model_serializers'
  spec.add_runtime_dependency 'railties', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.4'
end
