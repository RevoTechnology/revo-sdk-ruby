module RevoSDK
  class API
    attr_reader :config

    ENDPOINTS = {
      'return' => '/online/v1/return',
      'phone' => '/api/external/v1/client/limit',
      'preorder' => '/iframe/v1/auth',
      'order' => '/iframe/v1/auth'
    }.freeze

    def initialize(config)
      if config.configured?
        @config = config
      elsif RevoSDK.config.configured?
        @config = RevoSDK.config
      else
        raise Error.new('No config found')
      end
    end

    def order_payload(amount, order_id, additional_params)
      data = {
        callback_url: @config.callback_url,
        redirect_url: @config.redirect_url,
        current_order: {
          sum: '%.2f' % amount.to_f,
          order_id: order_id
        }
      }.merge!(additional_params)
      JSON.generate(data)
    end

    def phone_payload(phone)
      data = {
        client: {
          mobile_phone: phone
        }
      }
      JSON.generate(data)
    end

    def return_payload(amount, order_id)
      data = {
        order_id: order_id,
        sum: '%.2f' % amount.to_f,
        kind: 'cancel'
      }
      JSON.generate(data)
    end

    def call_service(data, type)
      signature = sign(data)

      uri = URI("#{@config.revo_host}/#{ENDPOINTS[type]}")
      uri.query = "store_id=#{@config.store_id}&signature=#{signature}"

      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      debug "uri.request_uri: #{uri.request_uri}"

      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = data
      response = http.request(request)

      debug "response: #{response}"
      raise_connection_error(response) if response.code != '200'

      debug "parsing response: #{response.body}"
      data = JSON.parse(response.body)

      if type == 'return'
        parse_return_response(data)
      elsif type == 'preorder' || type == 'order'
        parse_order_response(data)
      elsif type == 'phone'
        parse_phone_response(data)
      end
    end

    private

    def sign(data)
      Digest::SHA1.hexdigest(data + @config.secret)
    end

    def parse_order_response(data)
      if data['status'].zero?
        data['iframe_url']
      else
        raise_error(data)
      end
    end

    def parse_phone_response(data)
      if data['meta']['status'].zero?
        data['client']
      else
        raise_error(data['meta'])
      end
    end

    def parse_return_response(data)
      if data['status'].zero?
        { result: :ok }
      else
        raise_error(data)
      end
    end

    def raise_connection_error(response)
      logger.fatal "[#{response.code}] #{response.value}" if logger
      raise ConnectionError.new "[#{response.code}] #{response.value}"
    end

    def raise_error(response)
      logger.fatal "[#{response['status']}] #{response['message']}" if logger
      error = ERRORS[response['status']] || ConnectionError
      raise error.new "[#{response['status']}] #{response['message']}"
    end

    def debug(message)
      logger.debug(message) if logger
    end

    def logger
      @config.logger
    end
  end
end
