class TimeLayout
  attr_reader :layout_key, :layout, :xml_node

  def from_xml_node(xml_node)
    @xml_node = xml_node
    @layout_key = get_layout_key
    @layout = get_layout
  end

  def get_layout_key
    layout_key = @xml_node.xpath('//layout-key').first
    layout_key.text if layout_key
  end

  def get_layout
    starts = @xml_node.xpath('//start-valid-time')
    ends = @xml_node.xpath('//end-valid-time')
    starts.map.with_index do |start, i|
      [DateTime.parse(start.text), DateTime.parse(ends[i].text)]
    end
  end
end
