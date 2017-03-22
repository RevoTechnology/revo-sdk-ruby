require 'spec_helper'

RSpec.describe RevoSDK do
  describe '#config=' do
    before { @old_config = RevoSDK.config }
    after { RevoSDK.config = @old_config }

    it { expect { RevoSDK.config = 'config' }.to change { RevoSDK.config }.to('config') }
  end

  describe '#config' do
    it { expect(RevoSDK.config).to be_instance_of(RevoSDK::Config) }
  end
end
