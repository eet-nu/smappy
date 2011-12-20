require 'open-uri'
require 'rmagick'

module OSM
  class Tile
    SIZE = 256
    
    DEFAULT_OPTIONS = {
      x:            0,
      y:            0,
      zoomlevel:    0,
      url_template: 'http://tile.openstreetmap.org/%{zoomlevel}/%{x}/%{y}.png'
    }.freeze
    
    attr_accessor :zoomlevel, :x, :y, :url_template
    
    def initialize(options = {})
      options = DEFAULT_OPTIONS.merge(options)
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def to_image
      data = open(to_url).read
      Magick::Image.from_blob(data).first
    end
    
    # def precise_x
    #   @x.to_f
    # end
    # 
    # def precise_y
    #   @y.to_f
    # end
    
    def x
      @x.to_i
    end
    
    def y
      @y.to_i
    end
    
    def to_url
      url_template % { zoomlevel: zoomlevel, x: x, y: y }
    end
  end
end
