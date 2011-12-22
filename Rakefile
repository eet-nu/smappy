require 'bundler'

Bundler.setup
Bundler.require

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'static_osm'

namespace :osm do
  desc "Generate an example static map"
  task :generate_example do
    # Compare this image to:
    #
    #  * Google Maps:   http://maps.google.com/maps/api/staticmap?size=500x350&sensor=false&center=50.9985099,5.857652&zoom=15
    #  * OpenStreetMap: http://staticmap.openstreetmap.de/staticmap.php?center=50.9985099,5.857652&zoom=15
    #
    map     = OSM::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15)
    canvas  = map.to_image
    drawing = Magick::Draw.new
      
    marker   = OSM::Marker.new(map.center.latitude, map.center.longitude)
    position = marker.position_on_map(map)
      
    drawing.composite(position[0], position[1], marker.width, marker.height, marker.marker_image)
    drawing.draw(canvas)
      
    canvas.write 'tmp/map.png'
  end
end