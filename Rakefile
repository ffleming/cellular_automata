require "bundler/gem_tasks"
require 'rake/extensiontask'
spec = Gem::Specification.load('cellular_automata.gemspec')
Rake::ExtensionTask.new('cellular_c', spec)
