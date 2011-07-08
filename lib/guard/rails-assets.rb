require 'guard'
require 'guard/guard'

module Guard
  class RailsAssets < Guard
    def initialize(watchers=[], options={})
      super
      @options = options || {}
    end

    def start
      compile_assets if run_for? :start
    end

    def reload
      compile_assets if run_for? :reload
    end

    def run_all
      compile_assets if run_for? :all
    end

    def run_on_change(paths=[])
      compile_assets if run_for? :change
    end

    def compile_assets
      puts 'Compiling rails assets'
      result = system "bundle exec rake assets:clean assets:precompile"
      if result
        Notifier::notify 'Assets compiled'
      else
        Notifier::notify 'see the details in the terminal', :title => "Can't compile assets", :image => :failed
      end
    end

    private

    def run_for? command
      run_on = @options[:run_on]
      run_on = [:start, :change] if not run_on or run_on.empty? 
      run_on = [run_on] unless run_on.respond_to?(:include?)
      run_on.include?(command)
    end
  end
end
