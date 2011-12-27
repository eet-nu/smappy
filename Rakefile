require 'bundler'

Bundler.setup
Bundler.require

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'smappy'

namespace :smappy do
  desc "Generate an example static map"
  task :generate_example do
    # Compare this image to:
    #
    #  * Google Maps:   http://maps.google.com/maps/api/staticmap?size=500x350&sensor=false&center=50.9985099,5.857652&zoom=15
    #  * OpenStreetMap: http://staticmap.openstreetmap.de/staticmap.php?center=50.9985099,5.857652&zoom=15
    #
    map = Smappy::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15)
    
    # Cloudmade tiles:
    map.tile_url_template = 'http://a.tile.cloudmade.com/ed3b3505052b442dba7baff14f1ad671/47664/256/%{zoomlevel}/%{x}/%{y}.png'
    
    # Google Maps tiles:
    # map.tile_url_template = 'http://mt1.google.com/vt/x=%{x}&y=%{y}&z=%{zoomlevel}'
    
    image = map.to_image
      
    marker   = Smappy::Marker.new(map.center.latitude, map.center.longitude)
    position = marker.position_on_map(map)
    
    image.compose!(marker.marker_image, position[0], position[1])
    
    image.save 'tmp/map.png'
  end
end