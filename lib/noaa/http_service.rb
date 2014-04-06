module NOAA
  class HttpService #:nodoc:
    def initialize(http = Net::HTTP)
      @HTTP = http
    end

    def get_current_conditions(station_id)
       LibXML::XML::Document.string(get_html_document("http://w1.weather.gov/xml/current_obs/#{station_id}.xml"))
    end

    def get_forecast(num_days, lat, lng)
      params = { num_days: num_days, lat: lat, long: lng}
       LibXML::XML::Document.string(get_html_document("http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?", params))
    end

    def get_station_list
       LibXML::XML::Document.string(get_html_document("http://www.weather.gov/xml/current_obs/index.xml"))
    end

    def get_html_document(url, params = nil)
      request = Typhoeus::Request.new(url, {:followlocation => true, params: params} )
      request.run.body
    end
  end
end
