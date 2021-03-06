# DVB

[![Gem](https://img.shields.io/gem/v/dvb.svg?style=flat-square)](https://rubygems.org/gems/dvb) [![Travis](https://img.shields.io/travis/kiliankoe/dvbrb.svg?style=flat-square)](https://travis-ci.org/kiliankoe/dvbrb/builds) [![GitHub issues](https://img.shields.io/github/issues/kiliankoe/dvbrb.svg?style=flat-square)](https://github.com/kiliankoe/dvbrb/issues) [![Gemnasium](https://img.shields.io/gemnasium/kiliankoe/dvbrb.svg?style=flat-square)](https://gemnasium.com/github.com/kiliankoe/dvbrb)

This is an unofficial gem giving you a few options to query Dresden's public transport system for current bus- and tramstop data.

Want something like this for another language, look [no further](https://github.com/kiliankoe/vvo#libraries) 🙂

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dvb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dvb
## Quick Start

```ruby
# Don't forget to require dvb
require 'dvb'

# Calling the following will return a list of DVB::Departure objects
# encapsulating information about upcoming departures at the given stop. 
# I've also gone ahead and filtered out departures that do not have "3" 
# as their line identifier.

deps = DVB.monitor('albertplatz').select { |d| d.line == '3' }
puts deps
# 3 Coschütz @ 2016-08-29 17:57:58 +0200
# 3 Wilder Mann @ 2016-08-29 18:03:58 +0200
# 3 Coschütz @ 2016-08-29 18:07:58 +0200
# ...

# The second optional parameter sets a time offset into the future, 
# default is 0. The third optional parameter limits the amount of results, 
# default is as many as possible.

deps = DVB.monitor('albertplatz', 10, 2)
puts deps
# 8 Südvorstadt @ 2016-08-29 18:30:00 +0200
# 6 Wölfnitz @ 2016-08-29 18:31:00 +0200

```

```ruby
# You can also use dvb to find stops using two different methods. Either
# look them up by name or via coordinates. DVB::Stop objects include an id, 
# latitude, longitude, name, region and tarif_zones amongst other info.

# The second optional param is the region. It defaults to Dresden.
stops = DVB.find('helmh', 'Dresden')
puts stops
# Helmholtzstraße, Dresden

# The third optional param here is the searchradius in meters. 
# It defaults to 500.
stops = DVB.find_near(51.063313, 13.746748, 500)
puts stops
# Bautzner Straße / Rothenburger Straße, Dresden
# Albertplatz, Dresden
# Bahnhof Neustadt, Dresden
```

## Contributing

Please don't hesitate [opening an issue](https://github.com/kiliankoe/dvbrb/issues/new) should any questions/bugs/whatever arise.

Pull requests are of course just as welcome. If you're interested in adding additional functionality, why not open an issue beforehand so we can discuss how to integrate it best 😊


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## Why?

At this point I consider writing wrappers for the DVB/VVO APIs as somewhat of an extensive hello-world exercise for myself. I'm trying to get back into Ruby and realized I've never published a gem, so here goes nothing 😄
