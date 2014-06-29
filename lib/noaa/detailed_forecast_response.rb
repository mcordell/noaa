class DetailedForecastResponse
  attr_reader :time_layouts, :parameters
  attr_accessor :raw_xml, :xml_node

  def from_xml(xml)
    @raw_xml = xml
    @xml_node = Nokogiri::XML(xml)
    set_time_layouts
  end

  def set_time_layouts
    @time_layouts = {}
    @xml_node.xpath('//time-layout').each do |time_layout|
      layout = Timelayout.from_xml_node(time_layout)
      @time_layouts[layout.layout_key] = layout
    end
  end
end
