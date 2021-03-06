# -*- encoding: utf-8 -*-

$: << File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require 'noaa/version'

Gem::Specification.new do |s|
  s.name = %q{noaa}
  s.version = NOAA::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mat Brown", "Michael Cordell"]
  s.date = Date.today
  s.default_executable = %q{noaa-update-stations}
  s.description = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  s.email = %q{mat@patch.com}
  s.executables = ["noaa-update-stations"]
  s.files = Dir.glob('{bin,lib,spec,data}/**/*') + %w(CHANGELOG README.md)
  s.has_rdoc = true
  s.homepage = %q{http://github.com/outoftime/noaa}
  s.post_install_message = %q{Be sure to update the weather station list:

	sudo noaa-update-stations

This can be run at any time to update the stations, but you must run it once to initially populate the station list.}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Noaa", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{noaa}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  s.test_files = ["spec/lib/noaa/station_writer_spec.rb", "spec/lib/noaa/forecast_spec.rb", "spec/spec_helper.rb", "spec/lib/noaa/station_spec.rb", "spec/lib/noaa/http_service_spec.rb", "spec/lib/noaa/current_conditions_spec.rb"]
  s.add_runtime_dependency('nokogiri', '>= 0.9.7')
  s.add_runtime_dependency('typhoeus', '>= 0.6.8')
  s.add_runtime_dependency('geokit', '>= 1.5.0')
  s.add_development_dependency('rspec')
  s.add_development_dependency('guard')
  s.add_development_dependency('gem-release')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('pry')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')
end
