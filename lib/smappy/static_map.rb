require 'rmagick'

module Smappy
  class StaticMap
    DEFAULT_OPTIONS = {
      width:     500,
      height:    350,
      zoomlevel: 0,
      center:    [0.0, 0.0]
    }
    
    attr_accessor :width, :height, :zoomlevel, :center, :tile_url_template
    
    def initialize(options = {})
      options = DEFAULT_OPTIONS.merge(options)
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def center=(new_value)
      if new_value.is_a?(Location)
        @center = new_value
      else
        @center = Location.new(new_value[0], new_value[1])
      end
    end
    
    def center_tile
      center.to_tile zoomlevel: zoomlevel
    end
    
    def tile_offset
      center.position_on_tile(center_tile).map do |position|
        position - (Tile::SIZE / 2)
      end
    end
    
    def tile_options
      {
        zoomlevel:    zoomlevel,
        url_template: tile_url_template
      }.delete_if do |key, value|
        value.nil?
      end
    end
    
    def tiles
      # How many tiles do we need to fill the image:
      tile_width   = (width  / Tile::SIZE).to_i + 2
      tile_height  = (height / Tile::SIZE).to_i + 2
      
      # What are our first and last tiles:
      tile_x_start = (center_tile.x - (tile_width / 2)).to_i
      tile_x_end   = tile_x_start + tile_width
      tile_y_start = (center_tile.y - (tile_height / 2)).to_i
      tile_y_end   = tile_y_start + tile_height
      
      (tile_x_start..tile_x_end).map do |x|
        (tile_y_start..tile_y_end).map do |y|
          Tile.new(tile_options.merge(x: x, y: y))
        end
      end.flatten.reject do |tile|
        x,y = tile.position_on_map(self)
        (x + Tile::SIZE < 0 || x > width) || (y + Tile::SIZE < 0 || y > height)
      end
    end
    
    def to_image
      canvas  = Magick::Image.new(width, height)
      drawing = Magick::Draw.new
      
      tiles.each do |tile|
        position = tile.position_on_map(self)
        drawing.composite(position[0], position[1], Tile::SIZE, Tile::SIZE, tile.to_image)
      end
      
      drawing.draw(canvas)
      
      canvas
    end
  end
end
