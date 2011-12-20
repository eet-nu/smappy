# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "static_osm"
  s.summary     = "Generate static maps with OpenStreetMap."
  s.description = "Generate static maps with OpenStreetMap."
  s.files       = Dir["{lib}/**/*"] + ["LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version     = "0.0.1"
  
  s.add_dependency "rmagick"
end
