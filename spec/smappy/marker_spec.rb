require 'spec_helper'

describe Smappy::Marker do
  let(:marker) { Smappy::Marker.new(50.9985099, 5.857652) }
  
  describe '#initialize' do
    it 'sets a default image' do
      marker.image.should == File.expand_path('../../../markers/marker.png', __FILE__)
    end
    
    it 'sets a default offset' do
      marker.offset.should == [-12, -41]
    end
  end
  
  describe '#width' do
    it 'returns the width of the marker image' do
      marker.width.should == 25
    end
  end
  
  describe '#height' do
    it 'returns the height of the marker image' do
      marker.height.should == 41
    end
  end
  
  describe '#position_on_map' do
    let(:map) { Smappy::StaticMap.new(center: [50.9985099, 5.857652], zoomlevel: 15) }
    
    it 'returns the coordinates of the marker on the given map' do
      marker.position_on_map(map).should == [238, 134]
    end
    
    it 'returns the coordinates of the marker on the given map offset by the specified offset' do
      marker.offset = [0, 0]
      marker.position_on_map(map).should == [250, 175]
    end
  end
end
