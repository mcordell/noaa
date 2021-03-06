require "spec_helper"

describe NOAA do
  describe NOAA::HttpService do
    let(:http_service) { NOAA::HttpService.new() }

    describe "#get_current_conditions" do
      before do
        @station = 'KBFL'
        @current_observation_url = "http://w1.weather.gov/xml/current_obs/#{@station}.xml"
      end

      it 'returns a nokogiri XML document' do
        VCR.use_cassette('current_conditions') do
          expect(http_service.get_current_conditions(@station)).
          to be_a Nokogiri::XML::Document
        end
      end
    end

    describe "#get_forecast" do
      let(:forecast_url_base) { "http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?" }

      before do
        @lat = 38.7076896900004
        @long = -122.90249849699973
        @num_days = 4
        @params = { lat: @lat, num_days: @num_days, lon: @long }
      end

      it 'returns a XML document for forecast' do
        VCR.use_cassette('forecast') do
          expect(http_service.get_forecast( @num_days, @lat, @long)).
          to be_a Nokogiri::XML::Document
        end
      end
    end

    describe "#get_detailed_forecast" do
      let(:detailed_url) { 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php' }

      before do
        @lat = 38.7076896900004
        @long = -122.90249849699973
      end

      it 'returns a XML string for detailed forecast' do
        VCR.use_cassette('detailed_forecast') do
          expect(http_service.get_detailed_forecast(@lat, @long)[0..4]).to eq "<?xml"
        end
      end
    end


    describe "#get_station_list" do
      let(:station_list_url) { "http://www.weather.gov/xml/current_obs/index.xml" }

      it 'returns a XML document for station list' do
        VCR.use_cassette('station_list') do
          expect(http_service.get_station_list).
          to be_a Nokogiri::XML::Document
        end
      end
    end
  end
end
