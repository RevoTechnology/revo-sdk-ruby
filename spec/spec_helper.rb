require 'bundler/setup'
require 'revo_sdk'

require 'webmock/rspec'

WebMock.enable!
WebMock.disable_net_connect!

Dir['./spec/support/**/*.rb'].each { |f| require f }

RevoSDK.configure do |c|
  c.secret       = 'secret'
  c.store_id     = 1
  c.callback_url = 'http://example.com/callback_url'
  c.redirect_url = 'http://example.com/redirect_url'
  c.log          = false
  c.test         = false
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RevoSDK::RSpec::Helpers
end
