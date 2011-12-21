require File.expand_path('../../lib/static_osm',  __FILE__)
require 'rspec'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.stub_with :fakeweb
end

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.extend  VCR::RSpec::Macros
  
  # == Mock Framework
  config.mock_with :rspec
end
