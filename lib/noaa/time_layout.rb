class Timelayout
  attr_reader :layout_key, :layout
  extend Forwardable

  def_delegator :@layout, :[]

  def self.from_xml_node(xml_node)
    new(layout_key_from(xml_node), layout_from(xml_node))
  end

  def initialize(layout_key, layout)
    @layout_key = layout_key
    @layout = layout
  end

  private_class_method

  def self.layout_key_from(xml_node)
    xml_node.xpath('./layout-key').first.text
  end

  def self.layout_from(xml_node)
    starts = xml_node.xpath('./start-valid-time').map {|time|
      DateTime.parse(time)
    }
    ends = xml_node.xpath('./end-valid-time').map {|time|
      DateTime.parse(time)
    }

    ends.empty? ? starts : starts.zip(ends)
  end
end
