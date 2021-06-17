require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into :faraday
  c.filter_sensitive_data('<API_KEY>') { ENV['MARVEL_PUBLIC_KEY'] }
  c.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method,
     VCR.request_matchers.uri_without_params(:ts, :hash)]
  }
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
