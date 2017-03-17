require 'net/http'
require 'json'

require 'revo_sdk/version'
require 'revo_sdk/config'
require 'revo_sdk/client'
require 'revo_sdk/errors'
require 'revo_sdk/limit'
require 'revo_sdk/pre_order'
require 'revo_sdk/order'
require 'revo_sdk/return_order'

module RevoSDK
  extend self

  def config=(value)
    @config = value
  end

  def config
    @config ||= Config.new
  end

  def configure
    yield config
  end
end
