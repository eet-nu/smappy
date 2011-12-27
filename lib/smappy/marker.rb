require 'open-uri'
require 'chunky_png'

module Smappy
  class Marker < Location
    DEFAULT_IMAGE = File.expand_path('../../../markers/information_marker.png', __FILE__)
    
    attr_accessor :image, :offset
    
    def initialize(latitude, longitude)
      @image  = DEFAULT_IMAGE
      @offset = [-(width / 2),  -height].map(&:to_i)
      
      super
    end
    
    def width
      marker_image.width
    end
    
    def height
      marker_image.height
    end
    
    def position_on_map(map)
      x, y = super
      
      [x + offset[0], y + offset[1]]
    end
    
    # UNTESTED:
    def marker_image
      @marker_image ||= ChunkyPNG::Image.from_datastream(
        ChunkyPNG::Datastream.from_io(open(image))
      )
    end
  end
end
