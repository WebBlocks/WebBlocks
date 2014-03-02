# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web_blocks/version'

Gem::Specification.new do |spec|

  spec.name          = 'web_blocks'
  spec.version       = WebBlocks::VERSION
  spec.authors       = ['Eric Bollens']
  spec.email         = ['ebollens@ucla.edu']
  spec.description   = 'Package, configuration and dependency manager for web assets (SCSS, JS, images, and fonts)'
  spec.summary       = 'package, configuration and dependency manager for web assets (SCSS, JS, images, and fonts)'
  spec.homepage      = 'http://github.com/WebBlocks/WebBlocks'
  spec.license       = 'BSD'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'
  spec.add_dependency 'ruby-bower'
  spec.add_dependency 'execjs'
  spec.add_dependency 'extend_method'
  spec.add_dependency 'compass'
  spec.add_dependency 'sass-css-importer'
  spec.add_dependency 'fork'
  spec.add_dependency 'fssm'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'coveralls'

end
