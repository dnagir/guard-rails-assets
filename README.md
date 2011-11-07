# Guard::RailsAssets


Guard::RailsAssets compiles the assets within Rails 3.1 application whenever those change.

Tested on MRI 1.9.2 (please report if it works on your platform).

If you have any questions please contact me [@dnagir](http://www.ApproachE.com).

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed.

Add it to your `Gemfile`, preferably inside the test and development group:

```ruby
gem 'guard-rails-assets'
```

Add guard definition to your `Guardfile` by running:

```bash
$ bundle exec guard init rails-assets
```

## Configuration for Jasmine
In order to make it work better with Jasmine it is recommended to explicitly move files precompiled for testing into a separate directory.
This way it doesn't conflict with any files in `public/assets`.

This is optional and you can skip it for now.

Bu if you are in for that, then:

1. Add the option `config.assets.prefix = 'public/assets-test'` to `config/environments/test.rb` .
2. Replace all `public/assets` with `public/assets-test` in `spec/javascripts/support/jasmine.yml`.
3. Add `public/assets*` to your `.gitignore` (if you haven't yet).


## Options

In addition to the guard configuration, `guard-rails-assets` has options to specify when exacly to precompile assets.

- `:start` - compile assets when the guard starts (enabled by default)
- `:change` - compile assets when watched files change (enabled by default)
- `:reload` - compile assets when the guard quites (Ctrl-C) (not enabled by default)
- `:all` - compile assets when running all the guards (Ctrl-/) (not enabled by default)

You can also set the `:runner` option:

- `:cli` - compile assets using the rake task - the most correct method, but slow.
- `:rails` - compile assets by loading rails environment (default) - fast, but does not pick up changes. Additionally it relies on a single instance of your app to be loaded, so you can't have multiple guards with different rails configurations.

Additional options are:

- `:rails_env` - specify the Rails environment to use (defaults to 'test').
- `:digest` - overrides the `config.asset.digest` setting (for production env it is usually `true`, for test - `false`).


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
