require 'open-uri'
require 'rmagick'

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
      marker_image.columns
    end
    
    def height
      marker_image.rows
    end
    
    def position_on_map(map)
      x, y = super
      
      [x + offset[0], y + offset[1]]
    end
    
    # UNTESTED:
    def marker_image
      @marker_image ||= (
        data = open(image).read
        Magick::Image.from_blob(data).first
      )
    end
  end
end
