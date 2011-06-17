require 'guard'
require 'guard/guard'

module Guard
  class RailsAssets < Guard
    def initialize(watchers=[], options={})
      super
    end

    def start
      # Started
    end

    def reload
      # Ctrl-Z
    end

    def run_all
      # Ctr-\ - restarting stuff
    end

    def run_on_change(paths)
    end

    def compile_assets
      # clean
      # prefix or path
      # compile
      Notifier::notify '1 directory, 2 files', :title => 'Assets compiled'
    end

  end
end
