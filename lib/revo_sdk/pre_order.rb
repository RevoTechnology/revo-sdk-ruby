module RevoSDK
  module PreOrder
    extend self

    def config=(value)
      @config = value
    end

    def config
      @config ||= PreOrderConfig.new
    end

    def configure
      yield config
    end

    def get_iframe_link(additional_params = {})
      client = API.new(config)
      data = client.order_payload(1.00, "ORDER#{rand(9)**5}", additional_params)
      client.call_service(data, 'preorder')
    end
  end
end
