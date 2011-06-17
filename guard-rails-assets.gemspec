# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/version"

Gem::Specification.new do |s|
  s.name        = "guard-rails-assets"
  s.version     = Guard::RailsAssetsVersion::VERSION
  s.authors     = ["Dmytrii Nagirniak"]
  s.email       = ["dnagir@gmail.com"]
  s.homepage    = "http://github.com/dnagir/guard-rails-assets"
  s.summary     = %q{Guard for compiling Rails assets}
  s.description = %q{guard-rails-assets automatically generates JavaScript, CSS, Image files using Rails assets pipelie}

  s.rubyforge_project = "guard-rails-assets"

  s.add_dependency             'guard'
  s.add_development_dependency 'rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
