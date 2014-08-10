class DetailedForecastResponse
  attr_reader :time_layouts, :parameters
  attr_accessor :raw_xml, :xml_node, :data_value_sets

  def initialize(raw_xml = nil)
    @raw_xml = raw_xml
    @xml_node = Nokogiri::XML(@raw_xml) if @raw_xml
  end

  def self.from_xml(xml)
    return nil unless xml
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

  def get_sets_by_class_and_type(klass, type, data_sets = nil)
    get_sets_by_class(klass, get_sets_by_type(type))
  end

  def get_sets_by_class(klass, data_sets = nil)
    data_sets ||= self.data_value_sets
    data_sets.select { |ds| ds.value_class == klass }
  end

  def get_sets_by_type(type, data_sets = nil)
    data_sets ||= self.data_value_sets
    data_sets.select { |ds| ds.value_type == type }
  end

  def successful?
    true
  end
end
