require 'rails_helper' 
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe LocationDetectorWorker, type: :worker do

  it "process the job in the correct queue" do
    described_class.perform_async
    expect(described_class.queue).to eq('default')
  end

  describe 'When there is an error' do

    let(:location) { FactoryGirl.create(:location) }
    
    it "should update the location's address_fetch_error" do
      allow_any_instance_of(LocationDetector::Geocoder).to receive(:search).with('').and_raise(LocationDetector::EmptyAddressError)
      described_class.new.perform('', location.id)
      expect(location.reload.address_fetch_error).to_not be_blank

      allow_any_instance_of(LocationDetector::Geocoder).to receive(:search).with('foo').and_raise(LocationDetector::GeocodeError)
      described_class.new.perform('foo', location.id)
      expect(location.reload.address_fetch_error).to_not be_blank

      allow_any_instance_of(LocationDetector::Geocoder).to receive(:search).with('bar').and_raise(LocationDetector::GeocodeNoResultsFoundError)
      described_class.new.perform('bar', location.id)
      expect(location.reload.address_fetch_error).to_not be_blank      
    end

    it "should raise an exception if its not one of the known errrors" do
      allow_any_instance_of(LocationDetector::Geocoder).to receive(:search).and_raise(Exception)
      expect {
        described_class.new.perform('foo', location.id)
      }.to raise_error
    end

  end

  describe 'when there is no error' do
    let(:location) { FactoryGirl.create(:location) }

    it "should update location's lat long and formatted address" do
      result = {
        address: 'Some address, some state, USA',
        location: {'lat' => 50.333333, 'lng' => 9.333333}
      }
      allow_any_instance_of(LocationDetector::Geocoder).to receive(:search).and_return(result)
      described_class.new.perform('Some Address', location.id)
      expect(location.reload.formatted_address).to eq('Some address, some state, USA')
      expect(location.reload.latitude).to eq(50.333333)
      expect(location.reload.longitude).to eq(9.333333)
    end

  end

end
