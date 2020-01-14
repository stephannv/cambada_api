require 'rails_helper'

RSpec.describe Cambada::BaseAPI, type: :api do
  describe 'Mounted apps' do
    it 'mounts Cambada::V1::BaseAPI app' do
      expect(described_class.routes).to match(Cambada::V1::BaseAPI.routes)
    end
  end
end
