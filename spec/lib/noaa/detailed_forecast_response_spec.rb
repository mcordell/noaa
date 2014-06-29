require 'spec_helper'

describe DetailedForecastResponse do
  it { should respond_to :raw_xml }
  it { should respond_to :xml_node }
  it { should respond_to :from_xml }
  it { should respond_to :time_layouts }
  it { should respond_to :parameters }
  let(:detailed_forecast_response) { DetailedForecastResponse.new }


  context ".from_xml" do
    let(:xml) { '<xml></xml>'}

    before do
      detailed_forecast_response.from_xml(xml)
    end

    it "sets its xml_node" do
      expect(detailed_forecast_response.xml_node).not_to be_nil
    end

    it "sets its raw_xml" do
      expect(detailed_forecast_response.raw_xml).to eq xml
    end
  end

  context "when the xml_node has been set" do
    let(:detailed_data_path) { File.expand_path(File.join(__FILE__, '../../../','data','4-day-detailed.xml')) }

    before { detailed_forecast_response.from_xml(File.open(detailed_data_path)) }

    describe ".time_layouts" do
      it "returns a hash of hime layouts with keys being the layout keys" do
        expected_keys = %w[k-p24h-n7-1 k-p24h-n7-2 k-p12h-n14-3 k-p6h-n7-4 k-p3h-n38-5
                           k-p3h-n30-6 k-p3h-n22-7 k-p1h-n74-8 k-p6h-n20-9 k-p24h-n8-10
                           k-p24h-n1-11 k-p24h-n1-12 k-p24h-n2-13 k-p6d-n1-14 k-p1m-n1-15
                           k-p3m-n13-16 k-p24h-n7-17 k-p1h-n62-18 k-p1h-n35-19 k-p1h-n62-20]
        expect(detailed_forecast_response.time_layouts.keys).to eq expected_keys
      end
    end
  end
end
