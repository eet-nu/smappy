require 'spec_helper'

describe OSM::Tile do
  let(:tile) { OSM::Tile.new }
  
  describe '#initialize' do
    it 'sets a default zoomlevel' do
      tile.zoomlevel.should == 0
    end
    
    it 'sets the zoomlevel' do
      OSM::Tile.new(zoomlevel: 1).zoomlevel.should == 1
    end
    
    it 'sets a default x-coordinate' do
      tile.x.should == 0
    end
    
    it 'sets the x-coordinate' do
      OSM::Tile.new(x: 1).x.should == 1
    end
    
    it 'sets a default y-coordinate' do
      tile.y.should == 0
    end
    
    it 'sets the y-coordinate' do
      OSM::Tile.new(y: 1).y.should == 1
    end
    
    it 'sets a default url_template' do
      tile.url_template.should == 'http://tile.openstreetmap.org/%{zoomlevel}/%{x}/%{y}.png'
    end
    
    it 'sets the url_template' do
      tile = OSM::Tile.new(url_template: 'http://c.tah.openstreetmap.org/Tiles/tile/%{zoomlevel}/%{x}/%{y}.png')
      tile.url_template.should == 'http://c.tah.openstreetmap.org/Tiles/tile/%{zoomlevel}/%{x}/%{y}.png'
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
    it 'returns the image at the url' do
      img = tile.to_image
      [img.columns, img.rows].should == [256, 256]
    end
  end
  
  describe '#x' do
    it 'returns the floored x-coordinate' do
      OSM::Tile.new(x: 1.6).x.should == 1
    end
  end
  
  describe '#y' do
    it 'returns the floored y-coordinate' do
      OSM::Tile.new(y: 1.6).y.should == 1
    end
  end
end
