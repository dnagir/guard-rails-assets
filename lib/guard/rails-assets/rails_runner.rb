require 'rake/dsl_definition'
module Guard

  class RailsAssets::RailsRunner

    def initialize(options)
      
    end

    # Methods to run the asset pipeline
    # Taken from - https://github.com/rails/rails/blob/master/actionpack/lib/sprockets/assets.rake
    module AssetPipeline
      extend self
      extend Rake::DSL
      
      def clean
        assets = ::Rails.application.config.assets
        public_asset_path = File.join(::Rails.public_path, config.assets.prefix)
        rm_rf public_asset_path, :secure => true
      end

      def precompile
        Sprockets::Helpers::RailsHelper
        ::ActionView::Base
  
        config = ::Rails.application.config
        env    = ::Rails.application.assets
        target = ::Rails.root.join("public#{config.assets.prefix}")
  
        config.assets.precompile.each do |path|
          env.each_logical_path do |logical_path|
            if path.is_a?(::Regexp)
              next unless path.match(logical_path)
            else
              next unless ::File.fnmatch(path.to_s, logical_path)
            end
  
            if asset = env.find_asset(logical_path)
              filename = target.join(asset.digest_path)
              mkdir_p filename.dirname
              asset.write_to(filename)
              asset.write_to("#{filename}.gz") if filename.to_s =~ /\.(css|js)$/
            end
          end
        end
      end
    end

    def boot_rails
      @rails_booted ||= begin
        require "#{Dir.pwd}/config/environment.rb"
        true
      end
    end

    def run_compiler
      begin
        @failed = false
        AssetPipeline.clean
        AssetPipeline.precompile
      rescue => e
        puts "An error occurred compiling assets: #{e}"
        @failed = true
      end
    end

    # Runs the asset pipeline compiler.
    #
    # @return [ Boolean ] Whether the compilation was successful or not
    def compile_assets
      boot_rails
      run_compiler
      
      !failed?
    end

    def failed?
      @failed
    end
  end
end
