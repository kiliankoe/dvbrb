# DVB

[![Gem](https://img.shields.io/gem/v/dvb.svg?style=flat-square)](https://rubygems.org/gems/dvb) [![Travis](https://img.shields.io/travis/kiliankoe/dvbrb.svg?style=flat-square)](https://travis-ci.org/kiliankoe/dvbrb/builds) [![GitHub issues](https://img.shields.io/github/issues/kiliankoe/dvbrb.svg?style=flat-square)](https://github.com/kiliankoe/dvbrb/issues) [![Gemnasium](https://img.shields.io/gemnasium/kiliankoe/dvbrb.svg?style=flat-square)](https://gemnasium.com/github.com/kiliankoe/dvbrb)

This is an unofficial gem giving you a few options to query Dresden's public transport system for current bus- and tramstop data.

Similar libs also exist for [Node](https://github.com/kiliankoe/dvbjs), [Python](https://github.com/kiliankoe/dvbpy) and [Swift](https://github.com/kiliankoe/DVB) 😊

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dvb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dvb
## Usage

```ruby
require 'dvb'

# Calling the following will return a list of DVB::Departure objects
# encapsulating information about upcoming departures at the given stop. 
# I've also gone ahead and filtered out departures that do not have "3" 
# as their line identifier.

deps = DVB::monitor('albertplatz').select { |d| d.line == '3' }
puts deps
# 3 Coschütz @ 2016-08-29 17:57:58 +0200
# 3 Wilder Mann @ 2016-08-29 18:03:58 +0200
# 3 Coschütz @ 2016-08-29 18:07:58 +0200
# ...

# The second optional parameter sets a time offset into the future, 
# default is 0. The third optional parameter limits the amount of results, 
# default is as many as possible.

deps = DVB::monitor('albertplatz', 10, 2)
puts deps
# 8 Südvorstadt @ 2016-08-29 18:30:00 +0200
# 6 Wölfnitz @ 2016-08-29 18:31:00 +0200
```

## Contributing

Please don't hesitate [opening an issue](https://github.com/kiliankoe/dvbrb/issues/new) should any questions/bugs/whatever arise.

Pull requests are of course just as welcome. If you're interested in adding additional functionality, why not open an issue beforehand so we can discuss how to integrate it best 😊


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## Why?

At this point I consider writing wrappers for the DVB/VVO APIs as somewhat of an extensive hello-world exercise for myself. I'm trying to get back into Ruby and realized I've never published a gem, so here goes nothing 😄
