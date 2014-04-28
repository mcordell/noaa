require "spec_helper"

describe NOAA do
  describe NOAA::Forecast do
    it "(class) responds to from_xml" do
      expect(NOAA::Forecast).to respond_to :from_xml
    end

    describe "#from_xml" do
      it "initializes a Forecast document with the passed document" do
        xml_doc = double()
        expect(NOAA::Forecast).to receive(:new).with(xml_doc)
        NOAA::Forecast.from_xml(xml_doc)
      end
    end
  end
end
