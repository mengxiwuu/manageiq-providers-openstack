if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

Dir[Rails.root.join("spec/shared/**/*.rb")].each { |f| require f }
Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

require "manageiq-providers-openstack"

RSpec.configure do |config|
  config.filter_run_excluding(:qpid_proton) unless Gem.loaded_specs.has_key?(:qpid_proton)
end

VCR.configure do |config|
  config.ignore_hosts 'codeclimate.com' if ENV['CI']
  config.cassette_library_dir = File.join(ManageIQ::Providers::Openstack::Engine.root, 'spec/vcr_cassettes')
end
