class DetailedForecastResponse
  attr_reader :time_layouts, :parameters, :data_value_sets
  attr_accessor :raw_xml, :xml_node

  def initialize(raw_xml = null)
    @raw_xml = raw_xml
    @xml_node = Nokogiri::XML(@raw_xml) if @raw_xml
  end

  def self.from_xml(xml)
    response = DetailedForecastResponse.new(xml)
    response.set_time_layouts
    response.set_data_value_sets
    response
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
