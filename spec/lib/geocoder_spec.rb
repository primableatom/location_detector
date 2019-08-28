require 'rails_helper'

RSpec.describe LocationDetector::Geocoder do

  it "should return proper address and the parse the resonse" do
    VCR.use_cassette("success") do
      result = described_class.new.search('hafeezpet, hyderabad')
      expect(result[:address]).to_not be_blank
      expect(result[:location]['lat']).to_not be_blank
      expect(result[:location]['lng']).to_not be_blank
    end
    
  end

  it "should raise an error on empty address" do
    expect {
      described_class.new.search('')
    }.to raise_error(LocationDetector::EmptyAddressError)
  end

  it "should raise an error if results are not found" do
    VCR.use_cassette("error_not_found") do
      expect {
        described_class.new.search('aldjldjsjdskdjssdsd')
      }.to raise_error(LocationDetector::GeocodeNoResultsFoundError)
    end
  end
  
end
