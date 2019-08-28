require 'rails_helper'

RSpec.describe Api::V1::FeaturesController, type: :controller do

  before :each  do
    @api_key = FactoryGirl.create(:api_key)
  end

  describe '#GET index' do

    before :each do
      5.times do |i|
        FactoryGirl.create(:point, feature: FactoryGirl.create(:feature))
      end
    end
    
    it "should return features" do
      get :index, format: :json, params: {access_token: @api_key.access_token}
      expect(response).to have_http_status(:ok)
    end

    it "should respond to page and per_page params" do
      get :index, format: :json, params: {access_token: @api_key.access_token, page: 1, per_page: 2}
      expect(JSON.parse(response.body).length).to eq(2)
    end

  end

  describe '#GET show' do
    before :each do
      @feature = FactoryGirl.create(:feature)
      FactoryGirl.create(:point, feature: @feature)
    end

    it "should return a feature" do
      get :index, format: :json, params: {id: @feature.id, access_token: @api_key.access_token}
      expect(response).to have_http_status(:ok)
    end

  end

end
