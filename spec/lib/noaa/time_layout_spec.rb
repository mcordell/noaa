require 'spec_helper'

describe Timelayout do
  it { should respond_to :layout_key }
  it { should respond_to :layout }
  it { should respond_to :xml_node }
  it { should respond_to :from_xml_node }

  let(:time_layout) { Timelayout.new }

  describe ".from_xml_node" do
    context "when the passed xml node that contains a layout-key" do
      let(:layout_key) { 'k-p25h-n7-1' }

      before do
        xml = "<time-layout><layout-key>#{layout_key}</layout-key></time-layout>"
        @xml_node = Nokogiri::XML(xml)
        time_layout.from_xml_node(@xml_node)
      end

      it "sets its layout_key to the key" do
        expect(time_layout.layout_key).to eq layout_key
      end

      it "sets its xml_node" do
        expect(time_layout.xml_node).to eq @xml_node
      end
    end

    context "when the passed an xml node that contains a series of start-valid-time and end-valid-time points" do
      before do
        xml = "<time-layout>
        <start-valid-time>2014-05-01T08:00:00-07:00</start-valid-time>
        <end-valid-time>2014-05-01T20:00:00-07:00</end-valid-time>
        <start-valid-time>2014-05-02T08:00:00-07:00</start-valid-time>
        <end-valid-time>2014-05-02T20:00:00-07:00</end-valid-time>
        </time-layout>"
        time_layout.from_xml_node(Nokogiri::XML(xml))
      end

      it "sets its layout to an array of DateTime pairs" do
        time_layout.layout.each do |start_time,end_time|
          expect(start_time).to be_a DateTime
          expect(end_time).to be_a DateTime
        end
      end

      it "sets its layout to an array of DateTime pairs in the proper order" do
        expect(time_layout.layout[0][1]).to eq DateTime.parse('2014-05-01T20:00:00-07:00')
        expect(time_layout.layout[1][0]).to eq DateTime.parse('2014-05-02T08:00:00-07:00')
      end
    end
    context "when the passed an xml node that contains a series of only start-valid-time" do
      before do
        xml = "<time-layout>
        <start-valid-time>2014-05-01T08:00:00-07:00</start-valid-time>
        <start-valid-time>2014-05-02T08:00:00-07:00</start-valid-time>
        </time-layout>"
        time_layout.from_xml_node(Nokogiri::XML(xml))
      end

      it "sets its layout to an array of DateTimes" do
        time_layout.layout.each do |start_time,end_time|
          expect(start_time).to be_a DateTime
        end
      end

      it "sets its layout to an array of DateTime pairs in the proper order" do
        expect(time_layout.layout[0]).to eq DateTime.parse('2014-05-01T08:00:00-07:00')
        expect(time_layout.layout[1]).to eq DateTime.parse('2014-05-02T08:00:00-07:00')
      end
    end
  end
end
