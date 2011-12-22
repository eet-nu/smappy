require 'spec_helper'

describe Smappy::Tile do
  let(:tile) { Smappy::Tile.new }
  
  describe '#initialize' do
    it 'sets a default zoomlevel' do
      tile.zoomlevel.should == 0
    end
    
    it 'sets the zoomlevel' do
      Smappy::Tile.new(zoomlevel: 1).zoomlevel.should == 1
    end
    
    it 'sets a default x-coordinate' do
      tile.x.should == 0
    end
    
    it 'sets the x-coordinate' do
      Smappy::Tile.new(x: 1).x.should == 1
    end
    
    it 'sets a default y-coordinate' do
      tile.y.should == 0
    end
    
    it 'sets the y-coordinate' do
      Smappy::Tile.new(y: 1).y.should == 1
    end
    
    it 'sets a default url_template' do
      tile.url_template.should == 'http://tile.openstreetmap.org/%{zoomlevel}/%{x}/%{y}.png'
    end
    
    it 'sets the url_template' do
      tile = Smappy::Tile.new(url_template: 'http://c.tah.openstreetmap.org/Tiles/tile/%{zoomlevel}/%{x}/%{y}.png')
      tile.url_template.should == 'http://c.tah.openstreetmap.org/Tiles/tile/%{zoomlevel}/%{x}/%{y}.png'
    end
  end
  
  describe '#position_on_map' do
    let(:map)  { Smappy::StaticMap.new center: [50.9985099, 5.857652], zoomlevel: 15 }
    
    it 'returns the coordinates of the tile on the map' do
      tile = Smappy::Tile.new x: 16917, y: 10970, zoomlevel: 15
      tile.position_on_map(map).should == [205, 123]
      
      tile = Smappy::Tile.new x: 16918, y: 10970, zoomlevel: 15
      tile.position_on_map(map).should == [461, 123]
    end
  end
  
  describe '#to_url' do
    it 'returns the URL to the tile' do
      tile.to_url.should == "http://tile.openstreetmap.org/0/0/0.png"
    end
    
    it 'replaces the zoomlevel in the URL' do
      tile.stub(:zoomlevel).and_return(1)
      tile.to_url.should == "http://tile.openstreetmap.org/1/0/0.png"
    end
    
    it 'replaces the x-coordinate in the URL' do
      tile.stub(:x).and_return(1)
      tile.to_url.should == "http://tile.openstreetmap.org/0/1/0.png"
    end
    
    it 'replaces the y-coordinate in the URL' do
      tile.stub(:y).and_return(1)
      tile.to_url.should == "http://tile.openstreetmap.org/0/0/1.png"
    end
    
    it 'parses the url_template' do
      tile.url_template = 'http://c.tah.openstreetmap.org/Tiles/tile/%{zoomlevel}/%{x}/%{y}.png'
      tile.to_url.should == 'http://c.tah.openstreetmap.org/Tiles/tile/0/0/0.png'
    end
  end
  
  describe '#to_image' do
    use_vcr_cassette 'Tile#to_image'
    
    it 'returns the image at the url' do
      img = tile.to_image
      [img.columns, img.rows].should == [256, 256]
    end
  end
  
  describe '#x' do
    it 'returns the floored x-coordinate' do
      Smappy::Tile.new(x: 1.6).x.should == 1
    end
  end
  
  describe '#y' do
    it 'returns the floored y-coordinate' do
      Smappy::Tile.new(y: 1.6).y.should == 1
    end
  end
end
