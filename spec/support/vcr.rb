require 'vcr'
VCR.configure do |c|
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
