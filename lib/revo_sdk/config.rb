module RevoSDK
  class Config
    attr_accessor :callback_url, :redirect_url, :secret, :store_id, :test, :log
    attr_writer :logger

    DEFAULT_LOGGER = lambda do
      require 'logger'
      logger = Logger.new(STDERR)
      logger.progname = 'RevoSDK'
      logger.formatter = ->(_, datetime, progname, msg) { "#{datetime} (#{progname}): #{msg}\n" }
      logger
    end

    def initialize
      @log = false
      @test = true
    end

    def logger
      @logger ||= log ? DEFAULT_LOGGER.call : nil
    end

    def revo_host
      @test ? 'https://demo.revoplus.ru/' : 'https://r.revoplus.ru'
    end

    def configured?
      [@callback_url, @redirect_url, @secret, @store_id].all?
    end
  end

  class LimitConfig < Config; end
  class PreOrderConfig < Config; end
  class OrderConfig < Config; end
  class ReturnOrderConfig < Config; end
end
