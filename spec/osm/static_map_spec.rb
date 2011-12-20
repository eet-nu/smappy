require 'spec_helper'

describe OSM::StaticMap do
  let(:map) { OSM::StaticMap.new center: [50.9985099, 5.857652], zoomlevel: 15 }
  
  describe '#initialize' do
    it 'sets a default width' do
      OSM::StaticMap.new.width.should == 500
    end
    
    it 'sets a default height' do
      OSM::StaticMap.new.height.should == 350
    end
    
    it 'sets a default zoomlevel' do
      OSM::StaticMap.new.zoomlevel.should == 0
    end
    
    it 'sets a default center' do
      map = OSM::StaticMap.new
      center = map.center
      center.latitude.should == 0.0
      center.longitude.should == 0.0
    end
    
    it 'sets the width' do
      OSM::StaticMap.new(width: 200).width.should == 200
    end
    
    it 'sets the height' do
      OSM::StaticMap.new(height: 200).height.should == 200
    end
    
    it 'sets the zoomlevel' do
      OSM::StaticMap.new(zoomlevel: 1).zoomlevel.should == 1
    end
    
    it 'sets the center' do
      map = OSM::StaticMap.new(center: [50.9985099, 5.857652])
      center = map.center
      center.latitude.should  == 50.9985099
      center.longitude.should == 5.857652
    end
  end
  
  describe '#center=' do
    it 'sets the center' do
      map.center = OSM::Location.new(50.9985099, 5.857652)
      center = map.center
      
      center.latitude.should  == 50.9985099
      center.longitude.should == 5.857652
    end
    
    it 'accepts an array' do
      map.center = [50.9985099, 5.857652]
      center = map.center
      
      center.latitude.should  == 50.9985099
      center.longitude.should == 5.857652
    end
  end
  
  # describe '#offset_x' do
  #   it 'returns the x offset for the placement of tiles' do
  #     map.offset_x.should == -83
  #   end
  # end
  # 
  # describe '#offset_y' do
  #   it 'returns the y offset for the placement of tiles' do
  #     map.offset_y.should == -76
  #   end
  # end
  # 
  # describe '#center_tile' do
  #   it 'returns the tile that contains the center of the map' do
  #     map  = OSM::StaticMap.new(latitude: 50.9985099, longitude: 5.857652, zoomlevel: 15)
  #     tile = map.center_tile
  #     tile.x.should == 16917
  #     tile.y.should == 10970
  #   end
  # end
  # 
  # describe '#top_left_tile' do
  #   map = OSM::StaticMap.new(latitude: 50.9985099, longitude: 5.857652, zoomlevel: 15)
  #   tile = map.top_left_tile
  #   tile.x.should == 16916
  #   tile.y.should == 10969
  # end
  # 
  # describe '#bottom_right_tile' do
  #   map = OSM::StaticMap.new(latitude: 50.9985099, longitude: 5.857652, zoomlevel: 15)
  #   tile = map.bottom_right_tile
  #   tile.x.should == 16918
  #   tile.y.should == 10970
  # end
  
  describe '#to_image' do
    let(:map) { OSM::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15) }
    
    it 'returns an image of the specified size' do
      img = map.to_image
      [img.columns, img.rows].should == [500, 350]
    end
    
    it 'writes an image' do
      img = map.to_image
      img.write 'tmp/map.png'
    end
  end
end
