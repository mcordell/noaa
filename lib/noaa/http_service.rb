module NOAA
  class HttpService #:nodoc:
    def get_current_conditions(station_id)
      base_url = NOAA.configuration.current_obs_base_url
      Nokogiri::XML(get_html_document("#{base_url}#{station_id}.xml"))
    end

    def get_forecast(num_days, lat, lng)
      params = { num_days: num_days, lat: lat, lon: lng, format: '24 hourly' }
      Nokogiri::XML(get_html_document(NOAA.configuration.by_day_url, params))
    end

    def get_detailed_forecast(num_days, lat, lng)
      params = { num_days: num_days, lat: lat, lon: lng }
      Nokogiri::XML(get_html_document(NOAA.configuration.detailed_url, params))
    end

    def get_station_list
      Nokogiri::XML(get_html_document(NOAA.configuration.station_list_url))
    end

    def get_html_document(url, params = nil)
      request = Typhoeus::Request.new(url, followlocation: true,
                                           params: params)
      request.run.body
    end
  end
end
