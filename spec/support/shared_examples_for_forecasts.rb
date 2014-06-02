RSpec.shared_examples "forecast" do
  let(:forecast_class) { described_class }

  it "(class) responds to from_xml" do
    expect(forecast_class).to respond_to :from_xml
  end

  describe "#from_xml" do
    it "initializes a Forecast document with the passed document" do
      xml_doc = double()
      expect(forecast_class).to receive(:new).with(xml_doc)
      forecast_class.from_xml(xml_doc)
    end
  end
end
