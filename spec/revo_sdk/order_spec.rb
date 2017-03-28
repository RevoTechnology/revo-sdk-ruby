require 'spec_helper'

RSpec.describe RevoSDK::Order do
  describe '#get_iframe_link' do
    context 'with valid data' do
      before { stub_api_request('order/iframe_valid').perform }

      it 'returns iframe link' do
        expect(described_class.get_iframe_link(19.99, 'ORDER1')).to include('iframe/v1/form')
      end
    end

    context 'with invalid callback_url' do
      before do
        RevoSDK.config.callback_url = ''
        stub_api_request('order/iframe_invalid').perform
      end

      after { RevoSDK.config.callback_url = 'http://example.com/callback_url' }

      it 'returns error message' do
        expect { described_class.get_iframe_link(49.95, 'ORDER2') }.to raise_error(RevoSDK::API::Errors::OrderCallbackUrlMissing)
      end
    end
  end
end
