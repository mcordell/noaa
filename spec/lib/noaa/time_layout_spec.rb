require 'spec_helper'

describe Timelayout do
  describe "extracting from XML node" do
    let(:time_layout) { Timelayout.from_xml_node(Nokogiri::XML(xml).xpath('//time-layout')) }

    let(:layout_key) { "k-p25h-n6-1" }
    let(:start1) { "2014-05-01T08:00:00-07:00" }
    let(:end1) { "2014-05-01T20:00:00-07:00" }
    let(:start2) { "2014-05-02T08:00:00-07:00" }
    let(:end2) { "2014-05-02T20:00:00-07:00" }

    context "with a series of start and end time points" do
      let(:xml) do
        "<time-layout>
           <layout-key>#{layout_key}</layout-key>
           <start-valid-time>#{start1}</start-valid-time>
           <end-valid-time>#{end1}</end-valid-time>
           <start-valid-time>#{start2}</start-valid-time>
           <end-valid-time>#{end2}</end-valid-time>
         </time-layout>"
      end

      it "extracts the layout key" do
        expect(time_layout.layout_key).to eq(layout_key)
      end

      it "extracts start and end times" do
        expected = [[DateTime.parse(start1), DateTime.parse(end1)],
                    [DateTime.parse(start2), DateTime.parse(end2)]]
        expect(time_layout.layout).to eq expected
      end
    end

    context "with only start times" do
      let(:xml) do
        "<time-layout>
           <layout-key>#{layout_key}</layout-key>
           <start-valid-time>#{start1}</start-valid-time>
           <start-valid-time>#{start2}</start-valid-time>
         </time-layout>"
      end

      it "extracts start times" do
        expected = [DateTime.parse(start1), DateTime.parse(start2)]
        expect(time_layout.layout).to eq expected
      end
    end
  end
end
