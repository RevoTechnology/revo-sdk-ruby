require 'spec_helper'

RSpec.describe RevoSDK::Limit do
  describe '#phone' do
    context 'with valid data' do
      before { stub_api_request('limit/phone_success').perform }
      it 'returns hash with limit' do
        result = described_class.phone('9031234567')

        expect(result).to have_key('limit_amount')
        expect(result).to have_key('status')
      end
    end

    context 'with invalid secret' do
      before do
        RevoSDK.config.secret = 'non_valid'
        stub_api_request('limit/phone_invalid_signature').perform
      end
      it 'returns error message' do
        expect { described_class.phone('9031234567') }.to raise_error(RevoSDK::Client::Errors::SignatureWrong)
      end
    end
  end
end
