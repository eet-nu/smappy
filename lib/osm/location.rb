module OSM
  class Location
    attr_accessor :latitude, :longitude
    
    def initialize(latitude, longitude)
      self.latitude  = latitude
      self.longitude = longitude
    end
    
    def to_tile(options = {})
      tile = Tile.new options
      tile.x = tile_x_at_zoomlevel(tile.zoomlevel)
      tile.y = tile_y_at_zoomlevel(tile.zoomlevel)
      tile
    end
    
    def position_on_tile(tile)
      x = tile_x_at_zoomlevel(tile.zoomlevel)
      y = tile_y_at_zoomlevel(tile.zoomlevel)
      
      [x,y].map do |position|
        ((position - position.to_i) * Tile::SIZE).to_i
      end
    end
    
    private
    
    def tile_y_at_zoomlevel(zoomlevel)
      (
        (
          1 - Math.log(
            Math.tan(latitude * Math::PI / 180) + 
            1 / Math.cos(latitude * Math::PI / 180)
          ) / Math::PI
        ) / 2 * 2 ** zoomlevel
      )
    end
    
    def tile_x_at_zoomlevel(zoomlevel)
      (
        (
          (longitude + 180) / 360
        ) * (
          2 ** zoomlevel
        )
      )
    end
  end
end
  