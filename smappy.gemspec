require './lib/smappy'

Gem::Specification.new do |s|
  s.name        = "smappy"
  s.version     = Smappy::VERSION
  
  s.summary     = "Generate static maps."
  s.description = "Generate static maps of map tiles."
  
  s.authors     = ["Tom-Eric Gerritsen"]
  s.email       = "tomeric@eet.nu"
  s.homepage    = "http://github.com/eet-nu/smappy"
  
  s.files       = Dir["{lib}/**/*"] + ["LICENSE", "Rakefile", "Gemfile", "README.md"]
  
  s.add_dependency "rmagick"
end
