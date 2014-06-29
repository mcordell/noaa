class DataValueSet
  attr_accessor :raw_values, :xml_node, :value_class, :value_unit, :timelayout_key, :value_type, :value_description

  def initialize(xml_node)
    @xml_node = xml_node
  end


  def self.from_xml_node(xml_node)
    data_value_set = DataValueSet.new(xml_node)
    data_value_set.raw_values = self.extract_raw_values(xml_node)
    data_value_set.value_class = self.extract_value_class(xml_node)
    data_value_set.timelayout_key = self.extract_time_layout_key(xml_node)
    data_value_set.value_type = self.extract_value_type(xml_node)
    data_value_set.value_unit = self.extract_value_unit(xml_node)
    data_value_set.value_description = self.extract_value_description(xml_node)
    return data_value_set
  end

  def self.extract_raw_values(xml_node)
    xml_node.xpath('./value').map { |v| v.text }
  end

  def self.extract_value_class(xml_node)
    xml_node.name
  end

  def self.extract_value_unit(xml_node)
    xml_node.attr('units')
  end

  def self.extract_value_type(xml_node)
    xml_node.attr('type')
  end

  def self.extract_time_layout_key(xml_node)
    xml_node.attr('time-layout')
  end

  def self.extract_value_description(xml_node)
    xml_node.xpath('./name').text
  end
end
