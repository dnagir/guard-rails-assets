module Guard
  class RailsAssets::CliRunner
    def initialize(options)
    end

    def compile_assets
      system "bundle exec rake assets:clean assets:precompile"
    end
  end
end
