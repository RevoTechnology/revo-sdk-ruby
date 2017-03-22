require 'spec_helper'

RSpec.describe RevoSDK::ReturnOrder do
  describe '#proceed' do
    context 'with valid data' do
      before { stub_api_request('return_order/return_valid').perform }
      it 'returns hash with limit' do
        result = described_class.proceed(4.49, 'ORDER12345')

        expect(result).to eq(result: :ok)
      end
    end

    context 'with invalid order_id' do
      before do
        stub_api_request('return_order/return_invalid').perform
      end
      it 'returns error message' do
        expect { described_class.proceed(4.49, 'ORDER') }.to raise_error(RevoSDK::Client::Errors::WrongOrderIdFormat)
      end
    end
  end
end
