module LocationDetector
  class EmptyAddressError < StandardError
  end

  class GeocodeError < StandardError
  end

  class GeocodeNoResultsFoundError < StandardError
  end
  
  class Geocoder
    API_KEY = 'AIzaSyBwxWKbuDm04EY_8hMB6M7kIebDwvimKpQ'.freeze # for now hard code API Key
    GEOCODE_URL = "https://maps.googleapis.com/maps/api/geocode/json?key=#{API_KEY}"

    def search(address)
      validate_address(address)
      call(address)
    end
    
    private

    def call(address)
      resp = HTTParty.get(GEOCODE_URL, query: {address: address})
      if resp['status'] == "OK"
        parse_response(resp)
      else
        raise GeocodeError.new(resp['error_message']) if resp['error_message'].present?
        raise GeocodeNoResultsFoundError if resp['results'].empty?
      end
    end

    def validate_address(address)
      raise EmptyAddressError if address.blank?
      address
    end

    def parse_response(resp)
      {
        address: resp['results'].first['formatted_address'],
        location: resp['results'].first['geometry']['location']
      }
    end


  end
end
