require 'spec_helper'

RSpec.describe RevoSDK::Limit do
  describe '#phone' do
    context 'with valid exists phone' do
      before { stub_api_request('limit/phone_success').perform }
      it 'returns hash with limit' do
        result = described_class.phone('9031234567')

        expect(result['limit_amount']).to eq "9950.00"
        expect(result['status']).to eq 'active'
      end
    end

    context 'with valid new phone' do
      before { stub_api_request('limit/phone_new').perform }
      it 'returns hash with limit' do
        result = described_class.phone('9111111111')

        expect(result['limit_amount']).to eq "0.0"
        expect(result['status']).to eq 'new'
      end
    end

    context 'with invalid secret' do
      before do
        RevoSDK.config.secret = 'non_valid'
        stub_api_request('limit/phone_invalid_signature').perform
      end
      it 'returns error message' do
        expect { described_class.phone('9031234567') }.to raise_error(RevoSDK::API::Errors::SignatureWrong)
      end
    end
  end
end
