module RevoSDK
  module ReturnOrder
    extend self

    def config=(value)
      @config = value
    end

    def config
      @config ||= ReturnOrderConfig.new
    end

    def configure
      yield config
    end

    def proceed(amount, order_id)
      client = Client.new(config)
      data = client.return_payload(amount, order_id)
      client.call_service(data, 'return')
    end
  end
end
