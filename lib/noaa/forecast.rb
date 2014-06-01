module NOAA
  #
  # A Forecast object represents a multi-day forecast for a particular place. The forecast for a given day can
  # be accessed using the [] method; e.g. (assuming +forecast+ is a forecast for 12/20/2008 - 12/24/2008):
  #
  #   forecast[1]     #=> ForecastDay for 12/21/2008
  #   forecast.length #=> 4
  #
  class Forecast

    class <<self
      private :new

      def from_xml(doc) #:nodoc:
        new(doc)
      end
    end

    def initialize(doc) #:noinit:
      @doc = doc
    end
  end
end
