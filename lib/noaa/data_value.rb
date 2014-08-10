class DataValue
  attr_accessor :unit, :parameter, :value, :start_time, :end_time

  def initialize(value, unit)
    @value = value
    @unit = unit
  end
end

