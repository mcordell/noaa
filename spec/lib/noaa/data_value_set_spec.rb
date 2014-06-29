require 'spec_helper'

describe DataValueSet do
  describe "extracting from XML node" do
    let(:expected_values) { %w[0 0 0 0 0 0 0 18 16 20 12 7 5 1]}
    let(:expected_value_class) { 'probability-of-precipitation' }
    let(:expected_value_type) { '12 hour' }
    let(:expected_value_unit) { 'percent' }
    let(:expected_value_description) { '12 hourly probability of precipitation' }
    let(:expected_value_set_layout_key) { 'k-p12h-n14-3' }
    let(:xml) do
      "<#{expected_value_class} type='#{expected_value_type}' units='#{expected_value_unit}' time-layout='#{expected_value_set_layout_key}'>
        <name>#{expected_value_description}</name>
        <value>#{expected_values[0]}</value>
        <value>#{expected_values[1]}</value>
        <value>#{expected_values[2]}</value>
        <value>#{expected_values[3]}</value>
        <value>#{expected_values[4]}</value>
        <value>#{expected_values[5]}</value>
        <value>#{expected_values[6]}</value>
        <value>#{expected_values[7]}</value>
        <value>#{expected_values[8]}</value>
        <value>#{expected_values[9]}</value>
        <value>#{expected_values[10]}</value>
        <value>#{expected_values[11]}</value>
        <value>#{expected_values[12]}</value>
        <value>#{expected_values[13]}</value>
      </#{expected_value_class}>"
    end

    context "when provided an xml node with the proper layout" do
      let(:xml_node) { Nokogiri::XML(xml).children.first }
      let(:data_value_set) { DataValueSet.from_xml_node(xml_node)}

      it "extracts raw values" do
        expect(data_value_set.raw_values).to eq expected_values
      end

      it "creates a data value set with that xml node set" do
        expect(data_value_set.xml_node).to eq xml_node
      end

      it "extracts the value class" do
        expect(data_value_set.value_class).to eq expected_value_class
      end

      it "extracts the value unit" do
        expect(data_value_set.value_unit).to eq expected_value_unit
      end

      it "extracts the value type" do
        expect(data_value_set.value_type).to eq expected_value_type
      end

      it "extracts the value description" do
        expect(data_value_set.value_description).to eq expected_value_description
      end

      it "extracts the time layout key" do
        expect(data_value_set.timelayout_key).to eq expected_value_set_layout_key
      end
    end
  end
end
