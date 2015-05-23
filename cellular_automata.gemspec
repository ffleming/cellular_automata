# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cellular_automata/version'

Gem::Specification.new do |spec|
  spec.name          = "cellular_automata"
  spec.version       = CellularAutomata::VERSION
  spec.authors       = ["Forrest Fleming"]
  spec.email         = ["ffleming@gmail.com"]

  spec.summary       = %q{A simulation of cellular automata}
  spec.description   = %q{A set of 0-player games, of which Conway's Game of Life is a member.}
  spec.homepage      = "https://github.com/ffleming/cellular_automata"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.license       = 'MIT'

  spec.add_development_dependency "bundler", "~> 1", ">= 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'byebug', '~> 4'
  spec.add_development_dependency 'pry-byebug', '~> 3.1'
end
