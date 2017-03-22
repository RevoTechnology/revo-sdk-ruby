require 'spec_helper'

RSpec.describe RevoSDK::PreOrder do
  describe '#get_iframe_link' do
    context 'with valid data' do
      before { stub_api_request('pre_order/iframe_valid').perform }

      it 'returns iframe link' do
        expect(described_class.get_iframe_link).to include('iframe/v1/form')
      end
    end

    context 'with invalid store_id' do
      before do
        RevoSDK.config.store_id = 21
        stub_api_request('pre_order/iframe_invalid').perform
      end

      after { RevoSDK.config.store_id = 1 }

      it 'returns error message' do
        expect { described_class.get_iframe_link }.to raise_error(RevoSDK::Client::Errors::StoreNotFound)
      end
    end
  end
end
