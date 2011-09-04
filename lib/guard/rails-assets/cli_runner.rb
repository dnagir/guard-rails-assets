module Guard
  class RailsAssets::CliRunner
    def initialize(options={})
      @rails_env = (options[:rails_env] || 'test').to_s
    end

    def compile_assets
      system "RAILS_ENV=#{@rails_env} bundle exec rake assets:clean assets:precompile"
    end
  end
end
