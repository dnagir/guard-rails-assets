require 'rake/dsl_definition'
module Guard

  class RailsAssets::RailsRunner
    @@rails_booted = false # Only one rails app is allowed, so make it a class var

    def initialize(options)
    end

    # Methods to run the asset pipeline
    # See as a reference https://github.com/rails/rails/blob/master/actionpack/lib/sprockets/assets.rake
    def boot_rails
      return if @@rails_booted
      puts "------------BOOTING RAILS"
      require 'rake'
      require "#{Dir.pwd}/config/environment.rb"
      app = ::Rails.application
      puts "--- CACHE=#{app.assets.cache}"
      app.assets.cache = nil
      app.load_tasks
      @@rails_booted = true
      puts "-- BOOTED after?=#{@@rails_booted}"
    end


    # Runs the asset pipeline compiler.
    #
    # @return [ Boolean ] Whether the compilation was successful or not
    def compile_assets
      boot_rails
      return false unless @@rails_booted
      begin
        Rake::Task['assets:clean'].execute
        Rake::Task['assets:precompile'].execute
        true
      rescue => e
        puts "An error occurred compiling assets: #{e}"
        false
      end
    end
  end
end
