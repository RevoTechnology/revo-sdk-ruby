module RevoSDK
  module Limit
    extend self

    def config=(value)
      @config = value
    end

    def config
      @config ||= LimitConfig.new
    end

    def configure
      yield config
    end

    def phone(phone)
      client = API.new(config)
      data = client.phone_payload(phone)
      client.call_service(data, 'phone')
    end
  end
end
