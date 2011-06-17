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
      result = system "rm -rf public/assets && bundle exec rake assets:precompile"   
      if result
        tree = `tree public/assets`
        summary = tree.split("\n").last
        Notifier::notify summary, :title => 'Assets compiled'
      else
        Notifier::notify 'see the details in the terminal', :title => "Can't compile assets", :image => :failed
      end
    end

    private

    def run_for? command
      run_on = @options[:run_on]
      run_on = [:start, :all, :change] if not run_on or run_on.empty? 
      run_on.include?(command)
    end
  end
end
