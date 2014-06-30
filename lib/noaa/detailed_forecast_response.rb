class DetailedForecastResponse
  attr_reader :time_layouts, :parameters, :data_value_sets
  attr_accessor :raw_xml, :xml_node

  def from_xml(xml)
    @raw_xml = xml
    @xml_node = Nokogiri::XML(xml)
    set_time_layouts
    set_data_value_sets
  end

  def set_time_layouts
    @time_layouts = {}
    @xml_node.xpath('//time-layout').each do |time_layout|
      layout = Timelayout.from_xml_node(time_layout)
      @time_layouts[layout.layout_key] = layout
    end
  end

  def set_data_value_sets
    @data_value_sets = []
    @xml_node.xpath('//parameters').children.each do |node|
      set = DataValueSet.from_xml_node(node)
      if set
        set.layout = time_layouts[set.timelayout_key]
        @data_value_sets.push(set)
      end
    end
  end
end
