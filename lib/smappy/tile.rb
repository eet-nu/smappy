require 'open-uri'
require 'chunky_png'

module Smappy
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
    
    def position_on_map(map)
      center_tile_x = (map.width  / 2) - (Tile::SIZE / 2) - map.tile_offset[0]
      center_tile_y = (map.height / 2) - (Tile::SIZE / 2) - map.tile_offset[1]
      
      offset_x = (map.center_tile.x - x) * Tile::SIZE
      offset_y = (map.center_tile.y - y) * Tile::SIZE
      
      [center_tile_x - offset_x,
       center_tile_y - offset_y]
    end
    
    def to_image
      @tile_image ||= ChunkyPNG::Image.from_datastream(
        ChunkyPNG::Datastream.from_io(open(to_url))
      )
    end
    
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
