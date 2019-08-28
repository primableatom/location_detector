require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  
  
  before :each  do
    @api_key = FactoryGirl.create(:api_key)
  end

  describe '#POST create' do

    it "should increase location count for a valid address" do
      VCR.use_cassette("success") do
        expect {
          post :create, params: {address: 'hafeezpet, hyderabad', access_token: @api_key.access_token}
        }.to change(Location, :count).by(1)
      end
    end

    it "should not increase location count if if the address passed is blank" do
      expect {
        post :create, params: {address: '', access_token: @api_key.access_token}
      }.to change(Location, :count).by(0)
    end
    
    
  end

  describe '#GET show' do
    
    let!(:location) {
      FactoryGirl.create(:location, input_address: 'mountain view', formatted_address: 'Mountain View, CA, USA', latitude: 24.886, longitude: -70.269)
    }

    let!(:location_1) {
      FactoryGirl.create(:location, input_address: 'hafeezpet, hyderabad', formatted_address: 'Hafeezpet, Hyderabad, Telangana, India', latitude: 17.4841683, longitude: 78.3602942)
    }

    let!(:location_2) {
      FactoryGirl.create(:location, input_address: 'foo bar', address_fetch_error: 'No results found for this address')
    }    

    let!(:feature) {
      FactoryGirl.create(:feature)
    }
    let!(:point_1) {
      FactoryGirl.create(:point, latitude: 25.774, longitude: -80.19, feature: feature)
    }

    let!(:point_2) {
      FactoryGirl.create(:point, latitude: 18.466, longitude: -66.118, feature: feature)
    }
    let!(:point_3) {
      FactoryGirl.create(:point, latitude: 32.321, longitude: -64.757, feature: feature)
    }

    it "the location should lie inside the points" do
      get :show, params: { id: location.id, access_token: @api_key.access_token }
      resp = JSON.parse(response.body)
      expect(resp['inside']).to eq(true)
    end

    it "should lie outside the points" do
      get :show, params: { id: location_1.id, access_token: @api_key.access_token }
      resp = JSON.parse(response.body)
      expect(resp['inside']).to eq(false)
    end

    it "should show location's address_fetch_error if location hasn't detected a lat lng" do
      get :show, params: { id: location_2.id, access_token: @api_key.access_token }
      resp = JSON.parse(response.body)
      expect(resp['address_fetch_error']).to_not be_blank
    end
  end
  
end
