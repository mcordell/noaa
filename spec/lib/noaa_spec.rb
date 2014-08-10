require 'spec_helper'

describe NOAA do
  it { should respond_to :forecast }
  it { should respond_to :current_conditions }
  it { should respond_to :current_conditions_at_station }
  it { should respond_to :detailed_forecast }

  describe "#detailed_forecast" do
    it "downloads the forecast with HTTP service" do
      expect_any_instance_of(NOAA::HttpService).to receive(:get_detailed_forecast)
      NOAA.detailed_forecast(30, -142)
    end

    it "instantiates a Forecast object through #from_xml with the xml document from http service" do
      xml_doc = double()
      NOAA::HttpService.any_instance.stub(:get_detailed_forecast).and_return(xml_doc)
      expect(DetailedForecastResponse).to receive(:from_xml).with(xml_doc)
      NOAA.detailed_forecast(30, -142)
    end

    it "returns a forecast object" do
      xml_doc = double()
      NOAA::HttpService.any_instance.stub(:get_detailed_forecast).and_return(xml_doc)
      expect(NOAA.detailed_forecast(30, -142)).to be_a DetailedForecastResponse
    end
  end

  describe "#forecast" do
    it "returns a summary forecast" do
      xml_doc = double()
      NOAA::HttpService.any_instance.stub(:get_forecast).and_return(xml_doc)
      expect(NOAA.forecast(2, 30, -142)).to be_a NOAA::ForecastSummary
    end
  end
end
