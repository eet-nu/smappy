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
  
  describe '#center_tile' do
    it 'returns the tile that contains the center of the map' do
      tile = map.center_tile
      [tile.x, tile.y].should == [16917, 10970]
    end
  end
  
  describe '#tile_offset' do
    it 'returns the offset for the placement of tiles' do
      map.tile_offset.should == [-83, -76]
    end
  end
  
  describe '#tile_options' do
    let(:options) { map.tile_options }
    
    it 'returns a hash' do
      options.should be_a Hash
    end
    
    it 'includes the zoomlevel' do
      map.zoomlevel = 11
      options[:zoomlevel].should == 11
    end
    
    it 'includes the url_template' do
      map.tile_url_template = 'http://mt1.google.com/vt/x=%{x}&y=%{y}&z=%{zoomlevel}'
      options[:url_template].should == 'http://mt1.google.com/vt/x=%{x}&y=%{y}&z=%{zoomlevel}'
    end
    
    it 'does not include nil values' do
      map.tile_url_template = nil
      options.should_not have_key(:url_template)
    end
  end
  
  describe '#tiles' do
    it 'contains the tiles that are used by this map' do
      map.tiles.should have(6).tiles
    end
    
    it 'contains tiles that use the tile_options' do
      map.stub(:tile_options).and_return({ zoomlevel: 10, url_template: 'http://mt1.google.com/vt/x=%{x}&y=%{y}&z=%{zoomlevel}' })
      map.tiles.all? do |tile|
        tile.zoomlevel.should    == 10
        tile.url_template.should == 'http://mt1.google.com/vt/x=%{x}&y=%{y}&z=%{zoomlevel}'
      end
    end
  end
  
  describe '#to_image' do
    use_vcr_cassette 'StaticMap#to_image'
    
    let(:map) { OSM::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15) }
    
    it 'returns an image of the specified size' do
      img = map.to_image
      [img.columns, img.rows].should == [500, 350]
    end
  end
end
