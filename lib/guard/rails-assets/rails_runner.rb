require 'rake/dsl_definition'
module Guard

  class RailsAssets::RailsRunner
    include Rake::DSL

    @@rails_booted = false # Only one rails app is allowed, so make it a class var
    @@rails_env = nil
    @@digest = nil

    def initialize(options={})
      @@rails_env = (options[:rails_env] || 'test').to_s unless @@rails_booted
      @@digest = options[:digest]
    end

    def self.apply_hacks
      # TODO: Hack due to Rails 3.1 issue: https://github.com/rails/rails/issues/2663#issuecomment-1990121
      ENV["RAILS_GROUPS"] ||= "assets"
      ENV["RAILS_ENV"]    ||= @@rails_env
    end

    # Methods to run the asset pipeline
    # See as a reference https://github.com/rails/rails/blob/master/actionpack/lib/sprockets/assets.rake
    def self.boot_rails
      return if @@rails_booted
      puts "Booting Rails for #{@@rails_env} environment."
      require "fileutils"

      apply_hacks
      require 'rake'
      require "#{Dir.pwd}/config/environment.rb"
      app = ::Rails.application

      app.assets.cache = nil # don't touch my FS pls. (can we use `app.config.assets.cache_store = false` instead)?
      app.load_tasks
      @@rails_booted = true
    end


    def precompile
      config = Rails.application.config
      unless config.assets.enabled
        warn "Cannot precompile assets if sprockets is disabled. Enabling it."
        config.assets.enabled = true
      end

      # Ensure that action view is loaded and the appropriate
      # sprockets hooks get executed
      _ = ActionView::Base

      digest = @@digest.nil? ? config.assets.digest : @@digest

      config.assets.compile = true
      config.assets.digest  = digest
      config.assets.digests = {}

      env      = Rails.application.assets
      target   = File.join(Rails.public_path, config.assets.prefix)
      compiler = Sprockets::StaticCompiler.new(env,
                                               target,
                                               config.assets.precompile,
                                               :manifest_path => config.assets.manifest,
                                               :digest => config.assets.digest,
                                               :manifest => config.assets.digest.nil?)
      compiler.compile
    end


    # Runs the asset pipeline compiler.
    #
    # @return [ Boolean ] Whether the compilation was successful or not
    def compile_assets
      self.class.boot_rails
      return false unless @@rails_booted
      begin
        precompile
        true
      rescue => e
        puts "An error occurred compiling assets: #{e}"
        false
      ensure
        ::Rails.application.assets.instance_eval { expire_index! }
      end
    end
  end
end
