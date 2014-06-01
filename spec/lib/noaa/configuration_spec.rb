require "spec_helper"

describe NOAA do
  describe NOAA::Configuration do

    let(:configuration) { NOAA::Configuration.new() }


    it "populates itself with defaults on initialization" do
      NOAA::Configuration::DEFAULTS.each do |k,v|
        expect(configuration.send(k)).to be v
      end
    end

    it "responds to the accessors for the configuration variables" do
      variable_names = ['station', 'station', 'station_list_url',
                        'current_obs_base_url', 'by_day_url', 'detailed_url']
      variable_names.each do |var|
        expect(configuration).to respond_to var
        expect(configuration).to respond_to var + "="
      end
    end

    describe "#load_with_hash" do
      context "when the hash contains keys that match configuration attributes" do
        before do
          @new_station_value = "NEW STATION VALUE"
          @config_hash = { station: @new_station_value }
        end

        it "populates the configuration object" do
          configuration.load_with_hash(@config_hash)
          expect(configuration.station).to be @new_station_value
        end
      end
    end
  end

  it "allows configuration by passing a block" do
    new_station_value = "NEW STATION VALUE"
    NOAA.configure do |config|
      config.station = new_station_value
    end

    expect(NOAA.configuration.station).to eq new_station_value
  end

  it "allows access to the configuration object through the configuration method" do
    expect(NOAA.configuration).to be_a NOAA::Configuration
  end

  it { expect(NOAA).to respond_to :default_station }
end
