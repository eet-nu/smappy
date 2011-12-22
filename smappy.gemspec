require './lib/smappy'

Gem::Specification.new do |s|
  s.name        = "smappy"
  s.summary     = "Generate static maps."
  s.description = "Generate static maps of map tiles. Uses OpenStreetMap tiles by default."
  s.files       = Dir["{lib}/**/*"] + ["LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version     = Smappy::VERSION
  
  s.add_dependency "rmagick"
end
