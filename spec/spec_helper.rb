require 'rspec'
require 'guard/rails-assets'
require 'support/shared_examples'
require 'support/stdout_helper'
require 'guard/rails-assets/cli_runner'
require 'guard/rails-assets/rails_runner'

RSpec.configure do |config|
  config.color_enabled = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    ENV["GUARD_ENV"] = 'test'
    @project_path = Pathname.new(File.expand_path('../../', __FILE__))
  end

  config.after(:each) do
    ENV["GUARD_ENV"] = nil
  end
  
  config.include(Helpers)

end
