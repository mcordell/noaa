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
      it "returns a hash of time layouts" do
        detailed_forecast_response.time_layouts.each do |k,v|
          expect(v).to be_a Timelayout
        end
      end
    end
  end
end
