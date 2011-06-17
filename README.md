# Guard::RailsAssets


Guard::RailsAssets compiles all the assets in Rails 3.1 application automatically when files are modified.

Tested on MRI Ruby 1.9.2 (please report if it works on your platform).
Currently only POSIX system is supported. Sorry Windows guys :(

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
$ guard init rails-assets
```

## Rails 3.1

The Rails 3.1 is a mandatory requirement, but is not enforeced via dependencies for now.
The reason is that the assets are currently compiled via command line and thus this guard does not
explicitly depend on Rails.

Good thing about it is that assets will always be same as produced by Rails.
Bad thing is that it is pretty slow (~10 seconds) because it starts Rails from ground zero.

## Rails Assets Pipeline

The convention used in this guard are:

- assets prefix is set to 'assets' meaning that all assets are compiled in to `public/assets` folder;
- the assets folder is disposable and can be cleared out.

If the conventions above are not valid for you then perhaps you'd better submit a patch.

## Guardfile and Options

In addition to the standard configuration, this Guard has options to specify when exacly to precompile assets.

- `:start` - compile assets when the guard starts (default)
- `:reload` - compile assets when the guard quites (Ctrl-C) (not enabled)
- `:all` - compile assets when running all the guard (Ctrl-/) (default)
- `:change` - compile assets when watched files change (default)

For example:


```ruby
# compile ONLY when something changes
guard 'rails-assets', :run_on => :change do
  watch(%r{^app/assets/.+$})
end

# compile when something changes and when starting
guard 'rails-assets', :run_on => [:start, :change] do
  watch(%r{^app/assets/.+$})
end

# This is the default behaviour
guard 'rails-assets', :run_on => [:start, :change, :all] do
  watch(%r{^app/assets/.+$})
end
```

## Development

- Source hosted at [GitHub](https://github.com/dnagir/guard-rails-assets)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/guard-rails-assets/issues)


Pull requests are very welcome!

## License

(The MIT License)

Copyright (c) 2010 - 2011 Michael Kessler

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

