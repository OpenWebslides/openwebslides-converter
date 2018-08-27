# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openwebslides/converter/version'

Gem::Specification.new do |gem|
  gem.name          = 'openwebslides-converter'
  gem.version       = OpenWebslides::Converter::VERSION
  gem.summary       = 'Open Webslides Converter'
  gem.description   = 'Converts arbitrary content data formats to Open Webslides data format'
  gem.license       = 'MIT'
  gem.authors       = ['Florian Dejonckheere']
  gem.email         = 'florian@floriandejonckheere.be'
  gem.homepage      = 'https://rubygems.org/gems/openwebslides-converter'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)

  `git submodule --quiet foreach --recursive pwd`.split($INPUT_RECORD_SEPARATOR).each do |submodule|
    submodule.sub!("#{Dir.pwd}/", '')

    Dir.chdir(submodule) do
      `git ls-files`.split($INPUT_RECORD_SEPARATOR).map do |subpath|
        gem.files << File.join(submodule, subpath)
      end
    end
  end

  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'nokogiri', '~> 1.8'

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rdoc', '~> 4.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubocop', '~> 0.58'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'coveralls', '~> 0.8'
end
