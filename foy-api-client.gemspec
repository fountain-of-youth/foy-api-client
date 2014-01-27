lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foy_api_client'

Gem::Specification.new do |gem|
  gem.name          = "foy_api_client"
  gem.version       = Foy::API::Client::VERSION
  gem.authors       = ["Roberto Soares"]
  gem.email         = ["contact@robertosoares.me"]
  gem.summary       = %q{FoY API Client}
  gem.description   = %q{FoY API Client}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('rspec', '>= 2.14.1')
  gem.add_development_dependency('webmock', '>= 1.17.1')

  gem.add_dependency('rest-client', '>= 1.6.7')
end
