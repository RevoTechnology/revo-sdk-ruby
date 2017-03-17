module RevoSDK
  module Order
    extend self

    def config=(value)
      @config = value
    end

    def config
      @config ||= OrderConfig.new
    end

    def configure
      yield config
    end

    def get_iframe_link(amount, order_id, additional_params = {})
      client = Client.new(config)
      data = client.order_payload(amount, order_id, additional_params)
      client.call_service(data, 'order')
    end
  end
end
