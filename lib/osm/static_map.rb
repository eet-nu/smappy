require 'rmagick'

module OSM
  class StaticMap
    DEFAULT_OPTIONS = {
      width:     500,
      height:    350,
      zoomlevel: 0,
      center:    [0.0, 0.0]
    }
    
    attr_accessor :width, :height, :zoomlevel, :center
    
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
    
    def to_image
      # Create a new image:
      canvas  = Magick::Image.new(width, height)
      drawing = Magick::Draw.new
      
      # Fetch the center tile:
      center_tile = center.to_tile zoomlevel: zoomlevel
      
      # Get the x and y offset for the center tile:
      x_offset,
      y_offset = center.position_within_tile(center_tile).map do |position|
                   position - (Tile::SIZE / 2)
                 end
      
      # Coordinates of center tile:
      center_x = (width  / 2) - (Tile::SIZE / 2) - x_offset
      center_y = (height / 2) - (Tile::SIZE / 2) - y_offset
      
      # How many tiles do we need to fill the image:
      tile_width   = (width  / Tile::SIZE).to_i + 1
      tile_height  = (height / Tile::SIZE).to_i + 1
      
      # What are our first and last tiles:
      tile_x_start = (center_tile.x - (tile_width / 2)).to_i
      tile_x_end   = tile_x_start + tile_width
      tile_y_start = (center_tile.y - (tile_height / 2)).to_i
      tile_y_end   = tile_y_start + tile_height
      
      # Coordinates of first tile in image:
      start_x  = center_x - (center_tile.x - tile_x_start) * Tile::SIZE
      start_y  = center_y - (center_tile.y - tile_y_start) * Tile::SIZE
      
      (tile_x_start..tile_x_end).each do |x|
        (tile_y_start..tile_y_end).each do |y|
          tile = Tile.new(zoomlevel: zoomlevel, x: x, y: y)
          
          # Offset of tile:
          x_pos    = x - tile_x_start
          y_pos    = y - tile_y_start
          
          # Coordinates of this tile in image:
          pixels_x = start_x + x_pos * Tile::SIZE
          pixels_y = start_y + y_pos * Tile::SIZE
          
          # Add this tile to our image:
          drawing.composite(pixels_x, pixels_y, Tile::SIZE, Tile::SIZE, tile.to_image)
        end
      end
      
      drawing.draw(canvas)
      
      canvas
    end
  end
end
