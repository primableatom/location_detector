require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe '#generate_access_token' do

    it "should generate access_token" do
      api_key = FactoryGirl.create(:api_key)
      expect(api_key.access_token).should_not be_blank
    end
    
  end
end
