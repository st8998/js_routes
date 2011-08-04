# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "js_routes/version"

Gem::Specification.new do |s|
  s.name        = "js_routes"
  s.version     = JsRoutes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ivan Efremov"]
  s.email       = ["st8998@gmail.com"]
  s.homepage    = "https://github.com/st8998/js_routes"
  s.summary     = %q{}
  s.description = %q{}

  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "rails",   "~> 3.0"

  #s.rubyforge_project = "js_routes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
