class LocationDetectorWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5
  
  def perform(address, id)
    begin
      location = Location.find(id)
      result = LocationDetector::Geocoder.new.search(address)
      location.update_attributes!(
        formatted_address: result[:address], 
        latitude: result[:location]['lat'], 
        longitude: result[:location]['lng']
      )
    rescue LocationDetector::EmptyAddressError
      location.update_attributes!(address_fetch_error: "Empty Address")
    rescue LocationDetector::GeocodeError
      location.update_attributes!(address_fetch_error: "Something went wrong while find the address")
    rescue LocationDetector::GeocodeNoResultsFoundError
      location.update_attributes!(address_fetch_error: "No results found for this address")
    rescue Exception => e
      raise e
    end
  end
end
