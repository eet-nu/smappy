require File.expand_path('../../lib/static_osm',  __FILE__)
require 'rspec'
  
RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers
    
  # == Mock Framework
  config.mock_with :rspec
end
