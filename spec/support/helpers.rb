require 'yaml'

module RevoSDK
  module RSpec
    module Helpers
      class StubApiRequest
        attr_reader :name

        def initialize(name)
          @name = name
        end

        def perform
          webmock_stub.to_return(
            status: response[:status] || 200,
            body: response[:body] || '',
            headers: response_headers
          ) if webmock_stub
        end

        def to_return(options)
          webmock_stub.to_return(return_options.merge(options)) if webmock_stub
        end

        def to_raise(*args)
          webmock_stub.to_raise(*args) if webmock_stub
        end

        def to_timeout
          webmock_stub.to_timeout if webmock_stub
        end

        private

        def return_options
          {
            status: response[:status] || 200,
            body: response[:body] || '',
            headers: response_headers
          }
        end

        def webmock_stub
          @webmock_stub ||= begin
            if fixture
              WebMock::StubRegistry.instance.register_request_stub(WebMock::RequestStub.new(:post, url)).
                with(body: request_body, headers: request_headers)
            end
          end
        end

        def url
          if request[:url]
            "https://r.revoplus.ru/#{request[:url]}"
          else
            Regexp.new(request[:url_regexp])
          end
        end

        def request_body
          request[:body] || Regexp.new(request[:body_regexp])
        end

        def request_headers
          { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'}.merge(request[:headers] || {})
        end

        def response_headers
          { 'Content-Type' => 'application/json' }.merge(response[:headers] || {})
        end

        def request
          fixture[:request] || {}
        end

        def response
          fixture[:response] || {}
        end

        def fixture
          @fixture ||= begin
            file = fixture_path.join("#{name}.yml").to_s
            YAML.load(File.read(file)) if File.exist?(file)
          end
        end

        def fixture_path
          Pathname.new(File.expand_path('../../fixtures/', __FILE__))
        end
      end

      def stub_api_request(name)
        StubApiRequest.new(name)
      end
    end
  end
end
