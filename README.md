# Guard::RailsAssets


Guard::RailsAssets compiles the assets within Rails 3.1 application whenever those change.

Tested on MRI 1.9.2 (please report if it works on your platform).

If you have any questions please contact me [@dnagir](http://www.ApproachE.com).

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed.

Install the gem:

Add it to your `Gemfile`, preferably inside the test and development group:

```ruby
gem 'guard-rails-assets'
```

Add guard definition to your `Guardfile` by running:

```bash
$ bundle exec guard init rails-assets
```

## Options

In addition to the guard configuration, `guard-rails-assets` has options to specify when exacly to precompile assets.

- `:start` - compile assets when the guard starts (enabled by default)
- `:change` - compile assets when watched files change (enabled by default)
- `:reload` - compile assets when the guard quites (Ctrl-C) (not enabled by default)
- `:all` - compile assets when running all the guards (Ctrl-/) (not enabled by default)

Also you can set the `:runner` option:

- `:cli` - compile assets using the rake task - the most correct method, but slow.
- `:rails` - compile assets by loading rails environment (default) - fast, but does not pick up changes. Additionally it relies on a single instance of your app to be loaded, so you can't have multiple guards with different rails configurations.

You can also use `:rails_env` option to specify what Rails environment to use (defaults to 'test').


For example:


```ruby
# This is the default behaviour
guard 'rails-assets', :run_on => [:start, :change], :runner => :rails, :rails_env => 'test' do
  watch(%r{^app/assets/.+$})
end

# compile ONLY when something changes
guard 'rails-assets', :run_on => :change do
  watch(%r{^app/assets/.+$})
end

# compile when something changes and when starting
guard 'rails-assets', :run_on => [:start, :change] do
  watch(%r{^app/assets/.+$})
end
```

## Development

- Source hosted at [GitHub](https://github.com/dnagir/guard-rails-assets)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/guard-rails-assets/issues)

Pull requests are very welcome!

## Licensed under WTFPL

```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2011 Dmytrii Nagirniak <dnagir@gmail.com>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
