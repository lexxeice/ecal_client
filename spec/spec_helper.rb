$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ecal_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
  c.around :each, vcr: ->(value){ value.is_a?(String) } do |example|
    VCR.use_cassette(example.metadata[:vcr], record: :new_episodes, erb: true){ example.run }
  end
end
