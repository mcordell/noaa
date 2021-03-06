require 'yaml'
module NOAA
  class Configuration
    DEFAULTS = {
      station_list_url: 'http://w1.weather.gov/xml/current_obs/index.xml',
      current_obs_base_url: 'http://w1.weather.gov/xml/current_obs/',
      detailed_url: 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php',
      by_day_url: 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php' }

    attr_accessor :station, :station_list_url, :current_obs_base_url,
                  :by_day_url, :detailed_url

    def initialize
      load_with_hash(DEFAULTS)
    end

    def load_with_hash(hash)
      hash.each do |k, v|
        setter_command = "#{k}="
        send(setter_command, v) if respond_to? setter_command
      end
    end
  end
end
