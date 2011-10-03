require 'rake/dsl_definition'
module Guard

  class RailsAssets::RailsRunner
    include Rake::DSL

    @@rails_booted = false # Only one rails app is allowed, so make it a class var
    @@rails_env = nil

    def initialize(options={})
      @@rails_env = (options[:rails_env] || 'test').to_s unless @@rails_booted
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


    def clean
      Rake::Task["tmp:cache:clear"].execute
      # copy from the "assets:clean" Rake task
      config = ::Rails.application.config
      public_asset_path = File.join(Rails.public_path, config.assets.prefix)
      rm_rf public_asset_path, :secure => true
    end

    def precompile
      # copy from the "assets:precompile" Rake task

      # Ensure that action view is loaded and the appropriate sprockets hooks get executed
      ActionView::Base

      config = ::Rails.application.config
      config.assets.compile = true

      env    = ::Rails.application.assets

      # Always compile files and avoid use of existing precompiled assets
      config.assets.compile = true
      config.assets.digests = {}

      target = File.join(::Rails.public_path, config.assets.prefix)
      static_compiler = Sprockets::StaticCompiler.new(env, target, :digest => config.assets.digest)

      manifest = static_compiler.precompile(config.assets.precompile)
      manifest_path = config.assets.manifest || target
      FileUtils.mkdir_p(manifest_path)

      File.open("#{manifest_path}/manifest.yml", 'wb') do |f|
        YAML.dump(manifest, f)
      end
    end


    # Runs the asset pipeline compiler.
    #
    # @return [ Boolean ] Whether the compilation was successful or not
    def compile_assets
      self.class.boot_rails
      return false unless @@rails_booted
      begin
        clean
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
