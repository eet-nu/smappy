require 'spec_helper'

describe Smappy::Location do
  let(:location) { Smappy::Location.new(50.9985099, 5.857652) }
  
  describe '#to_tile' do
    it 'returns a tile at the default zoomlevel' do
      tile = location.to_tile
      tile.zoomlevel.should == 0
    end
    
    it 'returns a tile at the specified zoomlevel' do
      tile = location.to_tile zoomlevel: 15
      tile.zoomlevel.should == 15
    end
    
    it 'returns a tile with the correct position at the specified zoomlevel' do
      tile = location.to_tile zoomlevel: 15
      [tile.x, tile.y].should == [16917, 10970]
    end
  end
  
  describe '#position_on_map' do
    it 'returns the coordinates of the position on the given map' do
      map = Smappy::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15)
      position = location.position_on_map(map)
      position.should == [250, 175]
    end
  end
  
  describe '#position_on_tile' do
    it 'returns the coordinates of the position of the location within the given tile' do
      tile     = location.to_tile zoomlevel: 15
      position = location.position_on_tile tile
      position.should == [45, 52]
    end
  end
end
