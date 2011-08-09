require 'guard'
require 'guard/guard'

module Guard
  class RailsAssets < Guard
    def initialize(watchers=[], options={})
      super
      @options = options || {}
      @run_on = @options[:run_on] || [:start, :change]
      @run_on = [@run_on] unless @run_on.respond_to?(:include?)
    end

    def start
      runner.start if runner.respond_to? :start
      compile_assets if run_for? :start
    end

    def reload
      runner.reload if runner.respond_to? :reload
      compile_assets if run_for? :reload
    end

    def run_all
      compile_assets if run_for? :all
    end

    def run_on_change(paths=[])
      compile_assets if run_for? :change
    end

    def compile_assets
      puts "Compiling rails assets with #{runner.class.name}."
      result = runner.compile_assets

      if result
        Notifier::notify 'Assets compiled'
        puts 'Assets compiled.'
      else
        Notifier::notify 'see the details in the terminal', :title => "Can't compile assets", :image => :failed
        puts 'Failed to compile assets.'
      end
    end

    def runner
      @runner ||= begin
        runner_name = (@options[:runner] || :rails).to_s

        require "guard/rails-assets/#{runner_name}_runner"
        ::Guard::RailsAssets.const_get(runner_name.capitalize + 'Runner').new(@options)
      end
    end

    def run_for? command
      @run_on.include?(command)
    end
  end
end

